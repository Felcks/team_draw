import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/authentication/presentation/login/login_verification_page.dart';
import 'package:team_randomizer/modules/group/presentation/group_list/group_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LoginVerificationPage(),
    );
  }
}
