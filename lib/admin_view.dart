import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as photo;
import 'package:path_provider/path_provider.dart' as provider;

// LoginButton que hereda de la clase StatelessWidget,
//abarcará toda la interfaz del login. StatelessWidget, es
//un widget que no cambia, en este caso podemos utilizar dicha
//clase, si por ejemplo fuera un contador utilizariamos
//StatefulWidget, ya que son valores que cambian dinámicamente.
class AdminRoute extends StatelessWidget {
  const AdminRoute({
    Key? key,
  }) : super(key: key);

  //Variable de tipo String que permitirá validar el campo email
  //del formulario.

  @override
  Widget build(BuildContext context) {
    //Retornará un Scaffold, que constituirá toda la estructura del diseño
    //de la interfaz.
    return Scaffold(
      //Barra superior de la aplicación.
      appBar: AppBar(
        //Propiedad title que almacenará una variable de tipo Text, y se
        //le pasará un string para indicar el titulo de la aplicación.
        title: const Text("Vista administrador"),
      ),
      //Cuerpo de la interfaz, a la cual se le pasa un padding.
      body: Padding(
        //Propiedad padding, se le indicará un padding para todo de 20 px,
        //el padding se aplica con la clase EdgeInsets.
        padding: const EdgeInsets.all(20.0),
        //Hijo del cuerpo, el cual será un formulario.
        //Hijo, que será del tipo SingleChildScrollView, este widget
        //permitirá que el tamaño de la aplicación se adapte en función
        //de la interactividad de los usuarios con el formulario.
        child: SingleChildScrollView(
          //Hijo del widget SingleChildScrollView, será una columna,
          //que contendrá varios hijos en un array de Widget.
          child: Column(
            children: <Widget>[
              //Se asigna un padding superior de 20px.
              const Padding(padding: EdgeInsets.only(top: 20)),
              //Se hace otro padding, en este caso simétrico de 10 px.
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              //Se usa el widget MaterialButton, indicando el botón.
              MaterialButton(
                  //Propiedad color, a la que se le asigna el color blanco.
                  color: Colors.white,
                  //Propiedad child, que tendrá un Text, con una cadena para
                  //el botón.
                  child: const Text('Guardar foto'),
                  //Se utiliza la función onPressed que hemos creado y se le pasa
                  //a la propiedad onPressed.
                  onPressed: () => _recogerYTransformarImagen()),
              //Se usa el widget MaterialButton, indicando un botón.
            ],
          ),
        ),
      ),
    );
  }

  //Hay que crear un método que transforme la imagen

  _recogerYTransformarImagen() async {
    //Se crea la uri, a la que se realizará la petición https y se obtendrán
    //las foros en tamaño 400 de la página picsum.photos.
    var uri = Uri.https('picsum.photos', '/400');

    var response = await http.get(uri);

    photo.Image? imagen = photo.decodeJpg(response.bodyBytes);

    var guardarEnDirectorio = await provider.getApplicationDocumentsDirectory();

    print(guardarEnDirectorio.path);

    var rutaDirectorio = '${guardarEnDirectorio.path}/imagenDeFlutter.bmp';

    File(rutaDirectorio)
        .writeAsBytesSync(photo.encodeBmp(imagen!), flush: true);
  }
}
