import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../db/database_helper.dart';
import '../models/cv.dart';

class UpdateCVScreen extends StatefulWidget {
  final CV cv;

  const UpdateCVScreen({Key? key, required this.cv}) : super(key: key);

  @override
  State<UpdateCVScreen> createState() => _UpdateCVScreenState();
}

class _UpdateCVScreenState extends State<UpdateCVScreen> {
  late String name;
  late int age;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Compra/Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.cv.name,
                  decoration: const InputDecoration(hintText: 'Compra o Venta?'),
                  validator: (String? value) {
                    if(value == null || value.isEmpty || value != "Compra") {
                      if(value == null || value != "Venta") {
                        return 'Tienes que introducir "Compra" o "Venta"';
                      }
                    }

                    name = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.cv.age.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Compra/Venta date'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Compra/Venta date';
                    }

                    age = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var dog = CV(id: widget.cv.id, name: name, age: age);

                        var dbHelper = DatabaseHelper.instance;
                        int result = await dbHelper.updateCV(dog);

                        if (result > 0) {
                          Fluttertoast.showToast(msg: 'Dog Updated');
                          Navigator.pop(context, 'done');

                        }
                      }
                    },
                    child: const Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}