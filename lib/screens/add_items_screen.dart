import 'package:dogs_db_pseb_bridge/db/database_helper.dart';
import 'package:dogs_db_pseb_bridge/models/cv.dart';
import 'package:dogs_db_pseb_bridge/screens/cv_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCVScreen extends StatefulWidget {
  const AddCVScreen({Key? key}) : super(key: key);

  @override
  State<AddCVScreen> createState() => _AddCVScreenState();
}

class _AddCVScreenState extends State<AddCVScreen> {
  late String name;
  late int date;
  late int btc;
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Compra/Venta'),
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
                      hintText: 'Compra o Venta?'
                  ),
                  validator: (String? value){

                    if(value == null || value.isEmpty || value != "Compra") {
                      if(value == null || value != "Venta") {
                        return 'Tienes que introducir "Compra" o "Venta"';
                      }
                    }


                    name = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Fecha'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Tienes que introducir la fecha seguida';
                    }

                    date = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Cantidad Bitcoins'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Tienes que introducir la cantidad de bitcoins';
                    }

                    date = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                ElevatedButton(onPressed: () async {

                  if( formKey.currentState!.validate()){

                    var cove = CV(name: name, age: date);

                    var dbHelper =  DatabaseHelper.instance;
                    int result = await dbHelper.insertDog(cove);

                    if( result > 0 ){
                      Fluttertoast.showToast(msg: 'Guardando Compra/Venta...');
                    }
                  }


                }, child: const Text('Guardar Compra/Venta')),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const CVListScreen();
                  }));
                }, child: const Text('Ver listado de Compra/Venta')),

              ],
            ),
          ),
        ),
      ),
    );
  }
}