import 'package:flutter/material.dart';
import 'package:texno_bozor/ui/on_bording_screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double AppWidth = MediaQuery.of(context).size.width;
    double AppHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlutterLogo(
                  size: (200 / 812) * AppHeight,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ((50 / 812) * AppHeight),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the ',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              Text(
                'Texno Bozor',
                style: TextStyle(color: Colors.red, fontSize: 30),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: (24 / 375) * AppWidth),
                  child: SizedBox(
                      height: (50 / 812) * AppHeight,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(50 / 812) *
                                            AppHeight)),
                            elevation: MaterialStatePropertyAll<double>(
                                (20 * 812) * AppHeight),
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.redAccent)),
                        child: const Text('Elevate button'),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ((50 / 812) * AppHeight),
          ),
        ]),
      ),
    );
  }
}
