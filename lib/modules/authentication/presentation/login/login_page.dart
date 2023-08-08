import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_randomizer/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _userLoginFormKey = GlobalKey();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  bool _passwordVisible = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                  image: AssetImage('assets/football_bg.avif'),
                  colorFilter: ColorFilter.mode(
                    Colors.green.withOpacity(.25),
                    BlendMode.colorBurn,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Jogo Organizado",
                  style: TextStyle(color: Colors.white, fontSize: 80, fontFamily: "Varane"),
                ),
                Container(
                  child: Form(
                    key: _userLoginFormKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                controller: _emailController,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(fontSize: 15),
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                ),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                obscureText: !_passwordVisible,
                                controller: _passwordController,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: "Senha",
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
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
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.primary),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Iniciar sessão',
                                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  try {
                                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );

                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      print('No user found for that email.');
                                    } else if (e.code == 'wrong-password') {
                                      print('Wrong password provided for that user.');
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        height: 32.0,
                                        width: 32.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/google.jpg'), fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Text(
                                        'Entrar com Google',
                                        style:
                                            TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
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
                                }).catchError((e) { print(e); });
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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

  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) return null;

    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential userCredential = await auth.signInWithCredential(credential);

    _user = userCredential.user ?? null;

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
