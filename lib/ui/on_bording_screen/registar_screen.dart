import 'package:flutter/material.dart';
import 'package:texno_bozor/ui/on_bording_screen/login_screen.dart';
import 'package:texno_bozor/utils/images.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.red,
          title: const Text('Sign up'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter first Name',
                            labelText: 'first named',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter last Name',
                            labelText: 'Last named',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.lightBlue,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Mobile',
                            labelText: 'Mobile',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)))),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: (57),
                              width: (300),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {}
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    elevation:
                                        const MaterialStatePropertyAll<double>(
                                            10),
                                    backgroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.red)),
                                child: const Text('Register'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            'Or Sign Up Using',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 90),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  AppImages.google,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: Image.asset(
                                AppImages.google,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                AppImages.google,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 60),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
