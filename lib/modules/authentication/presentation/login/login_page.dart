import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_randomizer/main.dart';
import 'package:team_randomizer/modules/authentication/domain/repositories/user_repository.dart';
import 'package:team_randomizer/modules/authentication/domain/models/user.dart' as AppUser;
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  final GlobalKey<FormState> _userSigUpFormKey = GlobalKey();

  bool _isSignUp = false;
  bool _passwordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final UserRepository _userRepository = UserRepositoryImpl();

  String _loginError = "";
  String _signupError = "";

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: <Widget>[
            Container(
              width: deviceSize.width,
              height: deviceSize.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/football_bg.avif'),
                  colorFilter: ColorFilter.mode(
                    Colors.green.withOpacity(.25),
                    BlendMode.colorBurn,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Jogo Organizado",
                  style: TextStyle(color: Colors.white, fontSize: 40, fontFamily: "Varane"),
                ),
                (_isSignUp) ? signUpForms() : loginForms(),
              ],
            ),
          ],
        ),
      ),
      onWillPop: () async {
        //model.clearAllModels();
        return false;
      },
    );
  }

  void onSignInButtonPressed() {
    bool? isValid = _userLoginFormKey.currentState?.validate();
    if (isValid == true) {
      signInWithEmail();
    }
  }

  void signInWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _loginError = "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _loginError = "Não foi encontrado usuário com esse email";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _loginError = "Usuário e senha incompatíveis";
        });
      } else {
        if (e.code.isNotEmpty) {
          setState(() {
            _loginError = e.code.toString();
          });
        }
      }
    }
  }

  void onSignUpWithEmailPressed() {
    bool? isValid = _userSigUpFormKey.currentState?.validate();
    if (isValid == true) {
      signUpWithEmail();
    }
  }

  void signUpWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      User? user = credential.user;
      await user!.updateDisplayName(_nameController.text);
      //await user.reload();

      AppUser.User appUser =
          AppUser.User(id: const Uuid().v4(), authenticationId: user.uid, name: _nameController.text);
      _userRepository.createUser(appUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        setState(() {
          _signupError = "Email mal formatado";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _signupError = "Usuário e senha incompatíveis";
        });
      } else {
        print(_signupError);
        if (e.code.isNotEmpty) {
          setState(() {
            _signupError = e.code;
          });
        }
      }
    }
  }

  Widget loginForms() {
    return Form(
      key: _userLoginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Entrar",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    RegExpMatch? match = exp.firstMatch(value ?? "");
                    if (match == null) {
                      return "Insira um email válido";
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintText: "Email",
                    hintStyle: const TextStyle(fontSize: 15),
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: !_passwordVisible,
                  controller: _passwordController,
                  validator: (value) {
                    if ((value?.length ?? 0) < 6) {
                      return "A senha deve conter pelo menos 6 caracteres";
                    }

                    return null;
                  },
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintText: "Senha",
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintStyle: const TextStyle(fontSize: 15),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Iniciar sessão",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    onSignInButtonPressed();
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                _loginError,
                style: TextStyle(color: Colors.red.withRed(215)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    clearTextInputs();
                    _isSignUp = true;
                  });
                },
                child: const Text("Ainda não possui login? Registre-se"),
              ),
              Visibility(
                visible: false,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 32.0,
                            width: 32.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/google.jpg'), fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          const Text(
                            'Entrar com Google',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    signInWithGoogle().then((User? user) {
                      /*model.clearAllModels();
                                  Navigator.of(context).pushNamedAndRemoveUntil
                                    (RouteName.Home, (Route<dynamic> route) => false
                                  );*/
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpForms() {
    return Form(
      key: _userSigUpFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Registro",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    RegExpMatch? match = exp.firstMatch(value ?? "");
                    if (match == null) {
                      return "Insira um email válido";
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintText: "Email",
                    hintStyle: const TextStyle(fontSize: 15),
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: !_passwordVisible,
                  controller: _passwordController,
                  validator: (value) {
                    if ((value?.length ?? 0) < 6) {
                      return "A senha deve conter pelo menos 6 caracteres";
                    }

                    return null;
                  },
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintText: "Senha",
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintStyle: const TextStyle(fontSize: 15),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: !_passwordVisible,
                  controller: _passwordConfirmationController,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                  validator: (value) {
                    if ((value?.length ?? 0) < 6) {
                      return "A senha deve conter pelo menos 6 caracteres";
                    }

                    if(value != _passwordController.text) {
                      return "Ambas a senhas devem ser identicas";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintText: "Confirme a senha",
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintStyle: const TextStyle(fontSize: 15),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if ((value?.length ?? 0) < 3) {
                      return "Nome deve possuir pelo menos 3 caracteres";
                    }

                    return null;
                  },
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintText: "Nome",
                    hintStyle: const TextStyle(fontSize: 15),
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Registrar-se",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    onSignUpWithEmailPressed();
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                _signupError,
                style: TextStyle(color: Colors.red.withRed(215)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    clearTextInputs();
                    _isSignUp = false;
                  });
                },
                child: const Text("Voltar"),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearTextInputs() {
    _emailController.text = "";
    _nameController.text = "";
    _passwordController.text = "";
    _passwordConfirmationController.text = "";
    _signupError = "";
    _loginError = "";
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) return null;

    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential userCredential = await auth.signInWithCredential(credential);

    User? _user = userCredential.user ?? null;

    if (_user == null) return null;

    assert(!_user!.isAnonymous);

    assert(await _user!.getIdToken() != null);

    User currentUser = await auth.currentUser!;

    assert(_user!.uid == currentUser.uid);

    print("User Name: ${_user!.displayName}");
    print("User Email ${_user!.email}");

    return _user;
  }
}
