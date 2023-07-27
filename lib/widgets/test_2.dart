import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/onBoarding_provider.dart';

class CounterScreen2 extends StatelessWidget {
  const CounterScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deafult screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Consumer<OnBoardingProvider>(
              builder: (context, counterProvider, child) {
                return Text(
                  counterProvider.getCounter.toString(),
                  style: const TextStyle(fontSize: 45),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
