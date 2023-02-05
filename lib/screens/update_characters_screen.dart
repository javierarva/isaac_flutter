import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isaac_flutter/db/database_helper.dart';
import 'package:isaac_flutter/models/characters.dart';

class UpdateCharactersScreen extends StatefulWidget {
  final Characters characters;

  const UpdateCharactersScreen({Key? key, required this.characters}) : super(key: key);

  @override
  State<UpdateCharactersScreen> createState() => _UpdateCharactersScreenState();
}

class _UpdateCharactersScreenState extends State<UpdateCharactersScreen> {
  late String name;
  late String object;
  late String image;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Personaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.characters.name,
                  decoration: const InputDecoration(hintText: 'Nombre'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir un nombre.';
                    }

                    name = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.characters.object,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Objeto'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir un objeto.';
                    }

                    object = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.characters.image,
                  decoration: const InputDecoration(hintText: 'Imagen'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir una imagen.';
                    }

                    image = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var character = Characters(id: widget.characters.id, name: name, object: object, image: image);

                        var dbHelper = DatabaseHelper.instance;
                        int result = await dbHelper.updateCharacter(character);

                        if (result > 0) {
                          Fluttertoast.showToast(msg: 'Personaje Actualizado');
                          Navigator.pop(context, 'done');

                        }
                      }
                    },
                    child: const Text('Actualizar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}