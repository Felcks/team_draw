import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_randomizer/modules/authentication/domain/repositories/user_repository.dart';
import 'package:team_randomizer/modules/authentication/presentation/login/login_page.dart';
import 'package:team_randomizer/modules/group/presentation/group_list/group_list_page.dart';
import 'package:team_randomizer/modules/authentication/domain/models/user.dart' as AppUser;
import 'package:uuid/uuid.dart';

import '../../../../main.dart';

class LoginVerificationPage extends StatefulWidget {
  const LoginVerificationPage({Key? key}) : super(key: key);

  @override
  State<LoginVerificationPage> createState() => _LoginVerificationPageState();
}

class _LoginVerificationPageState extends State<LoginVerificationPage> {
  UserRepository _userRepository = UserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Visibility(
                visible: constraints.maxWidth >= 1200,
                child: Expanded(
                  child: Container(
                    height: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Firebase Auth Desktop',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth >= 1200 ? constraints.maxWidth / 2 : constraints.maxWidth,
                child: StreamBuilder<User?>(
                  stream: auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String? authenticationId = snapshot.data?.uid;
                      if (authenticationId == null) return LoginPage();

                      _userRepository.getUser(authenticationId).then(
                        (value) {
                          if (value.isEmpty) {
                            FirebaseAuth.instance.signOut();
                          } else {
                            loggedUser = value.first;
                          }
                        },
                      );

                      return GroupListPage();
                    }
                    return LoginPage();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
