import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './the_provider.dart';

class CounterByProvider extends StatelessWidget {
  const CounterByProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterProvide>(
        create: (context) => CounterProvide(),
        builder: (context, child) {
          return Scaffold(
            body: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () =>
                      Provider.of<CounterProvide>(context, listen: false)
                          .increment(),
                  child: const Icon(Icons.add),
                ),
                Consumer<CounterProvide>(
                  builder:(context, counter, child) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${counter.counter}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () =>
                      Provider.of<CounterProvide>(context, listen: false)
                          .decrement(),
                  child: const Icon(Icons.space_bar),
                ),
              ],
            )),
          );
        });
  }
}
