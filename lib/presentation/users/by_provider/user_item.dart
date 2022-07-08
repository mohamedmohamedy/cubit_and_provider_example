import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alter_data_provider.dart';

class UserItem extends StatelessWidget {
  final String name;
  final int id;

  const UserItem({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() =>  Provider.of<AlterDataProvider>(context, listen: false).selectUser(name, id),
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
