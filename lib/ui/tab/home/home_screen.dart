import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    print('log out');
                    context.read<AuthProvider>().logOut(context);
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ));
  }
}
