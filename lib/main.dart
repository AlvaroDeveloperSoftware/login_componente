import 'package:flutter/material.dart';
import 'package:login/admin_view.dart';
import 'package:login/usuario_view.dart';
import 'loggin_button.dart';

import 'package:mysql1/mysql1.dart';

import 'modelUser.dart';
import 'usuario_view.dart';

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
  State<Estado> createState() => _Estado();
}

//Clase _Estado que extiende de la clase Estado, la clase _Estado
//implementará el método sobreescrito build, para construir en el
//contexto el botón de validación.
class _Estado extends State<Estado> {
  @override
  Widget build(BuildContext context) {
    //Objeto de la clase LoginButton
    //Retornará el botón con el método aplicado tomando los campos email y password.
    return LoginButton(
      onPressed: (() => {
            if (_validarLogin(LoginButton.email, LoginButton.pass))
              {
                _obtenerUsuario(
                    LoginButton.email.toString(), LoginButton.pass.toString())
              }
          }),
      registerOnPressed: (() => {
            if (_validarLogin(LoginButton.email, LoginButton.pass))
              {
                _registrarUsuario(
                    LoginButton.email.toString(), LoginButton.pass.toString())
              }
          }),
    );
  }

  //Método para validar el login
  _validarLogin(String? email, String? pass) {
    //Expresion para realizar la validación del email
    String emailValid =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    //Expresion para realizar la validación de la contraseña
    String passwordValid =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regex = RegExp(emailValid);

    if (email == null || email.isEmpty || regex.hasMatch(email) == false) {
      _mensajeInformativo('Escribe de nuevo el email',
          'El email debe ser un email con formato válido');
      return false;
    }

    regex = RegExp(passwordValid);

    //Se comprueba que la contraseña no es nula ni esta vacía.
    if (pass == null || pass.isEmpty) {
      _mensajeInformativo('Error', 'La contraseña esta vacía');
      return false;
    }

    //Se comprueba que la contraseña cumple con el formato y con la longitud
    if (regex.hasMatch(pass) == false || pass.length < 10) {
      _mensajeInformativo(
          'Error', 'La contraseña debe ser mayor a 10 caracteres');
      return false;
    }

    return true;
  }

  //Método que se encargará de consultar los usuarios que existen
  //en la tabla de usuarios
  Future _obtenerUsuario(String email, String password) async {
    User user = User("email", "password", "rol");

    var conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      port: 3309,
      db: 'datos_app_flutter',
      user: 'root',
    ));

    //Consulta a la tabla de la base de datos.
    var consultaUsuarios = await conn.query(
        "SELECT email,aes_decrypt(password, 'usuarioaes'), rol FROM usuarios where email='" +
            email +
            "'");
    //Si la tabla no está vacia, se obtendrán los usuarios que existen
    //y se comprobará si el rol es Administrador o Usuario.

    if (consultaUsuarios.isNotEmpty) {
      //Se recorren la consulta y se obtiene los valores de los campos 0 - email,
      // 1 - password, 2 - rol
      for (var datos in consultaUsuarios) {
        user =
            User(datos[0].toString(), datos[1].toString(), datos[2].toString());
      }

      //Si el rol es Administrador o usuario, se redirigirá a su vista
      if (user.rol == "Administrador" ||
          user.rol.toLowerCase() == "administrador") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const AdminRoute()));
      }

      //Si el rol es Usuario o usuario, se redirigirá a la vista del usuario
      else if (user.rol == "Usuario" || user.rol.toLowerCase() == "usuario") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const UserRoute()));
      }
    } else {
      _mensajeInformativo('Logeese o registrese', 'Se desconoce el usuario');
    }
  }

  //Método que permitirá registrar un usuario, cuando se haga clic en registrarUsuario
  Future _registrarUsuario(String email, String password) async {
    var conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      port: 3309,
      db: 'datos_app_flutter',
      user: 'root',
    ));

    await conn
        .query("Insert into usuarios (email,password,rol) values ('" +
            email +
            "',aes_encrypt('" +
            password +
            "','usuarioaes'),'administrador')")
        .then((value) => null);

    conn.close();
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
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.black),
                ),
                //Función onPressed del componente TextButton, cuando se haga
                //clic en el botón de Cerrar, se cerrará la alerta de dialogo.
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
