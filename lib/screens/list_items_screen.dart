import 'package:dogs_db_pseb_bridge/db/database_helper.dart';
import 'package:dogs_db_pseb_bridge/screens/update_cv_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/cv.dart';

class CVListScreen extends StatefulWidget {
  const CVListScreen({Key? key}) : super(key: key);

  @override
  State<CVListScreen> createState() => _CVListScreenState();
}

class _CVListScreenState extends State<CVListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compra/Venta'),
      ),
      body: FutureBuilder<List<CV>>(
        future: DatabaseHelper.instance.getAllDogs(),
        builder: (BuildContext context, AsyncSnapshot<List<CV>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No se encuentran Compra/Venta en la Base de datos'));
            } else {
              List<CV> cove = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: cove.length,
                    itemBuilder: (context, index) {
                      CV dog = cove[index];
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
                                          dog.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Age: ${dog.age}')
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
                                                  return UpdateCVScreen(cv: dog);
                                                }));

                                            if (result == 'done') {
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
                                                        'ATENCIÓN!'),
                                                    content: const Text(
                                                        'Estas seguro de que quieres eliminar?'),
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

                                                            // delete dog

                                                            int result =
                                                            await DatabaseHelper
                                                                .instance
                                                                .deleteDog(
                                                                dog.id!);

                                                            if (result > 0) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                  msg:
                                                                  'Eliminando Compra/Venta...');
                                                              setState(() {});
                                                              // build function will be called
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Yes')),
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