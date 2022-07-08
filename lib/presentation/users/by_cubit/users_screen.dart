import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cubit_test/presentation/users/by_cubit/cubit/cubit.dart';
import 'package:cubit_test/presentation/users/by_cubit/cubit/states.dart';
import 'package:cubit_test/presentation/users/by_cubit/items_widget.dart';

class UsersScreenByCubit extends StatelessWidget {
  const UsersScreenByCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            TextFormField(
              controller: UserCubit.get(context).textController,
              onFieldSubmitted: (_) => UserCubit.get(context).insertIntoDatabase(),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => UserCubit.get(context).deleteRecord(),
                ),
                labelText: 'User name',
                suffixIcon: TextButton(
                  onPressed: () => UserCubit.get(context).insertIntoDatabase(),
                  child: const Text('Save'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    ItemsWidget(
                      name: UserCubit.get(context).usersData[index]['name'] , 
                      
                      id: UserCubit.get(context).usersData[index]['id']
                      ),
                itemCount: UserCubit.get(context).usersData.length,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
