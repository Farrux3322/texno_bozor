import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/auth_provider.dart';
import 'package:texno_bozor/ui/on_bording_screen/registar_screen.dart';
import 'package:texno_bozor/utils/images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text("Login Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 100,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(AppImages.google)),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: context.read<AuthProvider>().emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone number, email or username',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: context.read<AuthProvider>().passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscured,
                focusNode: textFieldFocusNode,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, //Hides label on focus or if filled
                  labelText: "Password",
                  filled: true, // Needed for adding a fill color
                  fillColor: Colors.white,
                  isDense: true, // Reduces height a bit
                  border: const OutlineInputBorder(
                      // Apply corner radius
                      ),
                  prefixIcon: const Icon(Icons.lock_rounded, size: 24),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggleObscured,
                      child: Icon(
                        _obscured
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 65,
              width: 360,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: (57),
                        width: (300),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthProvider>().logIn(context);
                            print('qilindi log in ');
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              elevation:
                                  const MaterialStatePropertyAll<double>(10),
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.red)),
                          child: const Text(
                            'Log in ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 62),
                    child: Text('Forgot your login details? '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: InkWell(
                        onTap: () {
                          print('hello');
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
