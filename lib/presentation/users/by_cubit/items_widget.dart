import 'package:cubit_test/presentation/users/by_cubit/cubit/cubit.dart';
import 'package:flutter/material.dart';


class ItemsWidget extends StatelessWidget {
  final String name;
  final int id;

  const ItemsWidget({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => UserCubit.get(context).selectUser(name, id),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
             CircleAvatar(
              child: Text(id.toString()),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(name)),
          ],
        ),
      ),
    );
  }
}
