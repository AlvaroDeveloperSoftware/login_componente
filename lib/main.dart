import 'package:flutter/material.dart';
import 'loggin_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Componente login',
        theme: ThemeData(),
        home: const MyHomePage(color: Colors.white, 
        title: 'Entrar'),
        );
  }

}
