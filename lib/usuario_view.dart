import 'package:flutter/material.dart';

//LoginButton que hereda de la clase StatelessWidget,
//abarcará toda la interfaz del login. StatelessWidget, es
//un widget que no cambia, en este caso podemos utilizar dicha
//clase, si por ejemplo fuera un contador utilizariamos
//StatefulWidget, ya que son valores que cambian dinámicamente.
class UserRoute extends StatelessWidget {
  const UserRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Retornará un Scaffold, que constituirá toda la estructura del diseño
    //de la interfaz.
    return Scaffold(
      //Barra superior de la aplicación.
      appBar: AppBar(
        //Propiedad title que almacenará una variable de tipo Text, y se
        //le pasará un string para indicar el titulo de la aplicación.
        title: const Text("Vista usuario"),
      ),
      //Cuerpo de la interfaz, a la cual se le pasa un padding.
      body: Padding(
        //Propiedad padding, se le indicará un padding para todo de 20 px,
        //el padding se aplica con la clase EdgeInsets.
        padding: const EdgeInsets.all(20.0),
        //Hijo, que será del tipo SingleChildScrollView, este widget
        //permitirá que el tamaño de la aplicación se adapte en función
        //de la interactividad de los usuarios con el formulario.
        child: SingleChildScrollView(
          //Hijo del widget SingleChildScrollView, será una columna,
          //que contendrá varios hijos en un array de Widget.
          child: Column(
            children: <Widget>[
              Text('Bievenido'),
              //Se asigna un padding superior de 20px.
              const Padding(padding: EdgeInsets.only(top: 20)),
              //Se hace otro padding, en este caso simétrico de 10 px.
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
