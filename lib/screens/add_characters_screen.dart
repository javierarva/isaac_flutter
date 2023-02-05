import 'package:isaac_flutter/db/database_helper.dart';
import 'package:isaac_flutter/models/characters.dart';
import 'package:isaac_flutter/screens/list_characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCharactersScreen extends StatefulWidget {
  const AddCharactersScreen({Key? key}) : super(key: key);

  @override
  State<AddCharactersScreen> createState() => _AddCharactersScreenState();
}

class _AddCharactersScreenState extends State<AddCharactersScreen> {
  late String name;
  late String object;
  late String image;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Personaje'),
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
                    if(value == null || value.isEmpty){
                      return 'Tienes que introducir un nombre.';
                    }

                    name = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Objeto'
                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return 'Tienes que introducir un objeto.';
                    }

                    object = value;
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
                      return 'Tienes que introducir una imagen.';
                    }

                    image = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                ElevatedButton(onPressed: () async {

                  if(formKey.currentState!.validate()){
                    var characters = Characters(name: name, object: object, image: image);

                    var dbHelper =  DatabaseHelper.instance;
                    int result = await dbHelper.insertCharacter(characters);

                    if(result > 0 ){
                      Fluttertoast.showToast(msg: 'Guardando Personaje...');
                    }
                  }

                }, child: const Text('Guardar Personaje')),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const CharactersListScreen();
                  }));
                }, child: const Text('Ver listado de Personajes')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}