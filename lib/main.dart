import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import './presentation/by_provider/counter_by_provider.dart';
import './presentation/by_cubit/counter_by_cubit.dart';

import './presentation/users/by_provider/users_screen.dart';
import './presentation/users/by_provider/alter_data_provider.dart';

import './presentation/users/by_cubit/users_screen.dart';
import './presentation/users/by_cubit/cubit/cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit()..initialDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UsersScreenByCubit(),
      ),
    );
  }
}
