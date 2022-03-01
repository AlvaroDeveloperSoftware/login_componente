import 'package:flutter/material.dart';
import 'loggin_button.dart';

// Método main de la aplicación
void main() => runApp(const MyApp());

// Clase a lanzar por el método main.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


// Método que construye un Widget y devuelve el diseño que se le indique.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Componente login',
        theme: ThemeData(),
        home: const Estado(),
        );
  }
}

//Se crea un clase Estado que hereda de la clase
//StatefulWidget, que permitirá crear el estado de la aplicación.
class Estado extends StatefulWidget {
  const Estado({Key? key}) : super(key: key);

  @override
  State <Estado> createState() => _Estado();
}
//Clase _Estado que extiende de la clase Estado, la clase _Estado
//implementará el método sobreescrito build, para construir en el
//contexto el botón de validación.
class _Estado extends State<Estado>{
  @override
  Widget build(BuildContext context) {
    //Objeto de la clase LoginButton
    //Retornará el botón con el método aplicado tomando los campos email y password.
    return LoginButton(onPressed: (() => _validarLogin(LoginButton.email, LoginButton.pass)),
    );
  }


//Método que permitirá validar el correo y la contraseña
//que se indiquen en el formulario.
  _validarLogin(String? email, String? pass) {
  String correo = "usuario@gmail.com";
  String password = "usuario";

  if(email != correo && pass != password){
    return _mensajeInformativo('Error', 'Los datos son incorrectos');
  }
  else {
    return _mensajeInformativo('Login completado', 'Credenciales correctas');

  }
}

//Método que retornará una alerta de dialogo, tomando
//en cuenta las comprobación del método _validarLogin.
 _mensajeInformativo(String titulo, String mensaje) {
    return showDialog(
      //contexto de compilación de la aplicación.
      context: context,
      //contruye un contexto que será utilizado en la alerta
      //de dialogo
      builder: (BuildContext context) {
        return AlertDialog(
          //propiedad title, que recibirá un string.
          title: Text(titulo),
          //propiedad content, que indica el contenido, de tipo String.
          content: Text(mensaje),
          //acciones, que será una lista de componentes,
          //en este caso será el componente TextButton.
          actions: <Widget>[
            TextButton(
              //Este componente tendrá un hijo con el texto de dicho botón, 
              //y estilo del texto.
              child: Text("CERRAR", style: TextStyle(color: Colors.black),),
              //Función onPressed del componente TextButton, cuando se haga
              //clic en el botón de Cerrar, se cerrará la alerta de dialogo.
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );
      });
 }
  
}