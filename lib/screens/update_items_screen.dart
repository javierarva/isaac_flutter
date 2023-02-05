import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isaac_flutter/models/items.dart';
import '../db/database_helper.dart';

class UpdateItemsScreen extends StatefulWidget {
  final Items items;

  const UpdateItemsScreen({Key? key, required this.items}) : super(key: key);

  @override
  State<UpdateItemsScreen> createState() => _UpdateItemsScreenState();
}

class _UpdateItemsScreenState extends State<UpdateItemsScreen> {
  late String name;
  late String description;
  late String image;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Ítems'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.items.name,
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
                  initialValue: widget.items.description,
                  decoration: const InputDecoration(hintText: 'Descripción'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir una descripción.';
                    }

                    description = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.items.image,
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
                        var items = Items(name: name, description: description, image: image);

                        var dbHelper = DatabaseHelper.instance;
                        int result = await dbHelper.updateItem(items);

                        if (result > 0) {
                          Fluttertoast.showToast(msg: 'Ítem Actualizado');
                          Navigator.pop(context, 'Hecho');

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