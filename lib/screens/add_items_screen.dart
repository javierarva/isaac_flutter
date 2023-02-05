import 'package:isaac_flutter/db/database_helper.dart';
import 'package:isaac_flutter/models/items.dart';
import 'package:isaac_flutter/screens/list_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  late String name;
  late String description;
  late String image;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Ítem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Nombre'
                  ),
                  validator: (String? value){
                      if(value == null || value.isEmpty) {
                        return 'Tienes que introducir el nombre del ítem';
                      }

                    name = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Descripción'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Tienes que introducir una descripción';
                    }

                    description = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Imagen'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Tienes que introducir la imagen';
                    }

                    image = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                ElevatedButton(onPressed: () async {

                  if(formKey.currentState!.validate()){
                    var items = Items(name: name, description: description, image: image);

                    var dbHelper =  DatabaseHelper.instance;
                    int result = await dbHelper.insertItem(items);

                    if( result > 0 ){
                      Fluttertoast.showToast(msg: 'Guardando...');
                    }
                  }

                }, child: const Text('Guardar')),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ItemsListScreen();
                  }));
                }, child: const Text('Ver listado de Ítems')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}