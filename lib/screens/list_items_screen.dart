import 'package:isaac_flutter/db/database_helper.dart';
import 'package:isaac_flutter/screens/update_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/items.dart';

class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({Key? key}) : super(key: key);

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ítems'),
      ),
      body: FutureBuilder<List<Items>>(
        future: DatabaseHelper.instance.getAllItems(),
        builder: (BuildContext context, AsyncSnapshot<List<Items>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('No se encuentran ítems en la Base de Datos'));
            } else {
              List<Items> isaac = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: isaac.length,
                    itemBuilder: (context, index) {
                      Items item = isaac[index];
                      return Card(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Descripción: ${item.description}')
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            var result =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) {
                                              return UpdateItemsScreen(
                                                  items: item);
                                            }));

                                            if (result == 'Hecho') {
                                              setState(() {});
                                            }
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        '¡ATENCIÓN!'),
                                                    content: const Text(
                                                        '¿Estás seguro de que quieres eliminarlo?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('No')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            int result =
                                                                await DatabaseHelper
                                                                    .instance
                                                                    .deleteItem(
                                                                        item.id!);

                                                            if (result > 0) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          'Eliminando...');
                                                              setState(() {});
                                                            }
                                                          },
                                                          child:
                                                              const Text('Sí')),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  )
                                ],
                              )));
                    }),
              );
            }
          }
        },
      ),
    );
  }
}
