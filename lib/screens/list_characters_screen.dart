import 'package:isaac_flutter/db/database_helper.dart';
import 'package:isaac_flutter/screens/update_characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isaac_flutter/models/characters.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({Key? key}) : super(key: key);

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personajes'),
      ),
      body: FutureBuilder<List<Characters>>(
        future: DatabaseHelper.instance.getAllCharacters(),
        builder: (BuildContext context, AsyncSnapshot<List<Characters>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                      'No se encuentran Personajes en la Base de Batos'));
            } else {
              List<Characters> characters = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      Characters character = characters[index];
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
                                          character.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Objeto: ${character.object}')
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
                                              return UpdateCharactersScreen(Characters: characters);
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
                                                    title:
                                                        const Text('¡ATENCIÓN!'),
                                                    content: const Text(
                                                        '¿Estás seguro de que quieres eliminar?'),
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
                                                                    .deleteCharacter(
                                                                        character.id!);

                                                            if (result > 0) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          'Eliminando Personaje...');
                                                              setState(() {});
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
