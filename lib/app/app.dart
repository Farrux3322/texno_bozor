import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/auth_provider.dart';
import 'package:texno_bozor/ui/auth/auth_screen.dart';
import 'package:texno_bozor/ui/tab/tab_box.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthProvider>().listenAuthState(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            print('>>>>>>>>>>>>>>>> app  screen ga kirdi');
            return const AuthScreen();
          } else {
            return const TabBoxScreen();
          }
        },
      ),
    );
  }
}
