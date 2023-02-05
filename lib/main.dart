import 'package:isaac_flutter/screens/add_items_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OscarImbernol_JavierArroyes',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const AddItemsScreen(),
    );
  }
}
