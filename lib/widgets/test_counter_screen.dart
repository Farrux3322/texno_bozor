import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/onBoarding_provider.dart';
import 'package:texno_bozor/widgets/test_2.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OnBoardingProvider>(context, listen: false);

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
          TextButton(
              onPressed: () {
                provider.increment();
              },
              child: const Text("Increment")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CounterScreen2()));
              },
              child: const Text('press'))
        ],
      ),
    );
  }
}