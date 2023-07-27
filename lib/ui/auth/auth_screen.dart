import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/auth_provider.dart';
import 'package:texno_bozor/ui/auth/pages/login_page.dart';
import 'package:texno_bozor/ui/auth/pages/sign_up_page.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isLoginPage ? "Login" : "Sign Up"),
        ),
        body: Stack(
          children: [
            isLoginPage
                ? LoginPage(
              onChanged: () {
                setState(() {
                  isLoginPage = false;
                });
              },
            )
                : SignUpScreen(
              onChanged: () {
                setState(() {
                  isLoginPage = true;
                });
              },
            ),
            Visibility(
              visible: context.watch<AuthProvider>().isLoading,
              child: const Align(
                alignment: Alignment.center,
                child: CupertinoActivityIndicator(),
              ),
            )
          ],
        ));
  }
}
