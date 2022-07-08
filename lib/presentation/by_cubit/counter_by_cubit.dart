import 'package:cubit_test/presentation/by_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './cubit.dart';

class CounterByCubit extends StatelessWidget {
  const CounterByCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterInitialState) {
            debugPrint('this is initial state');
          }
          if (state is CounterIncrementState) {
            debugPrint('this is increment state');
          }
          if (state is CounterDecrementState) {
            debugPrint('this is decrement state');
          }
        },
        builder: (context, state) =>  Scaffold(
          body: Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () => CounterCubit.get(context).increment(),
                child: const Icon(Icons.add),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${CounterCubit.get(context).counter}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              FloatingActionButton(
                onPressed: () => CounterCubit.get(context).decrement(),
                child: const Icon(Icons.space_bar),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
