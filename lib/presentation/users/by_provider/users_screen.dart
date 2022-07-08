import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './alter_data_provider.dart';
import './user_item.dart';

class UsersScreenByProvider extends StatelessWidget {
  const UsersScreenByProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<AlterDataProvider>(context, listen: false);

    return FutureBuilder(
      future: Provider.of<AlterDataProvider>(context, listen: false)
          .initialDatabase(),
      builder: (context, snapshot) => Consumer<AlterDataProvider>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
              body: Column(
            children: [
              TextFormField(
                controller: dataProvider.textController,
                onFieldSubmitted: (_) => dataProvider.insertIntoDatabase(),
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        Provider.of<AlterDataProvider>(context, listen: false)
                            .deleteData(),
                  ),
                  labelText: 'User name',
                  suffixIcon: TextButton(
                    onPressed: () => dataProvider.insertIntoDatabase(),
                    child: Text(
                        dataProvider.wantedUser.isEmpty ? 'Save' : 'Update'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => UserItem(
                      name: dataProvider.dataRecords[index]['name'],
                      id: dataProvider.dataRecords[index]['id']),
                  itemCount: dataProvider.dataRecords.length,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
