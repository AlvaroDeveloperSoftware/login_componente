import 'package:flutter/material.dart';
//Clase LoginButton que hereda de la clase StatelessWidget, 
//abarcará toda la interfaz del login. StatelessWidget, es
//un widget que no cambia, en este caso podemos utilizar dicha
//clase, si por ejemplo fuera un contador utilizariamos
//StatefulWidget, ya que son valores que cambian dinámicamente.
class LoginButton extends StatelessWidget {
  LoginButton({Key? key, @required this.onPressed}) : super(key: key);
   
 //Variable final que recogerá la clave del formulario, para toda la
 //aplicación
  final formKey = GlobalKey<FormState>();
  //Variable de tipo String que permitirá validar el campo email
  //del formulario.
  static String? email;
  //Variable pass que permitirá validar el campo password del formulario.
  static String? pass;
  //Boton que validará el formulario.
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    //Retornará un Scaffold, que constituirá toda la estructura del diseño
    //de la interfaz.
    return Scaffold(
      //Barra superior de la aplicación.
      appBar: AppBar(
        //Propiedad title que almacenará una variable de tipo Text, y se
        //le pasará un string para indicar el titulo de la aplicación.
        title: const Text("Validando login"),
      ),
      //Cuerpo de la interfaz, a la cual se le pasa un padding.
      body: Padding(
        //Propiedad padding, se le indicará un padding para todo de 20 px, 
        //el padding se aplica con la clase EdgeInsets.
        padding: const EdgeInsets.all(20.0),
        //Hijo del cuerpo, el cual será un formulario.
        child: Form(
          //Clave para el formulario que lo hará único.
          key: formKey,
          //Hijo, que será del tipo SingleChildScrollView, este widget
          //permitirá que el tamaño de la aplicación se adapte en función
          //de la interactividad de los usuarios con el formulario.
          child: SingleChildScrollView(
            //Hijo del widget SingleChildScrollView, será una columna, 
            //que contendrá varios hijos en un array de Widget.
            child: Column(children: <Widget>[
              //Se inserta una imagen
              Image.asset('assets/images/login_image.png',
                    width: 440, height: 280),
              //Se asigna un padding superior de 20px.
              const Padding(padding: EdgeInsets.only(top: 20)),
              //Se llaman a los widgets del formulario.
              _emailInput(),
              _passwordInput(),
              //Se hace otro padding, en este caso simétrico de 10 px.
              const Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              //Se usa el widget MaterialButton, indicando un botón.
              MaterialButton(
                //Propiedad color, a la que se le asigna el color blanco.
                color: Colors.white,
                //Propiedad child, que tendrá un Text, con una cadena para
                //el botón.
                child: const Text('Entrar'),
                //Se utiliza la función onPressed que hemos creado y se le pasa
                //a la propiedad onPressed.
                onPressed: onPressed),
            ],
            ),
        ),
      ),
       ),
    );
  }

//Método que devuelve un Padding, con el TextField del campo email.
  Widget _emailInput() {
    //Devolverá un padding.
    return Padding(
      //Se le asigna un padding para todo de 16 px.
        padding: const EdgeInsets.all(16.0),
        //Tiene un nodo hijo, de tipo TextFormField, indicando
        //que se trata de un campo de tipo formulario.
        child: TextFormField(
          //Método que permitirá verificará el cambio de valor del formulario.
          onChanged: ((value) => email = value),
          //propiedad decoration, a la que se le indicará decoración con la clase
          //InputDecoration, se le indica la propiedad hintText y se le pasará
          //una indicación de que se trata de Email, y se le indica
          //la propiedad label para asignar una etiqueta que es Email.
            decoration: const InputDecoration(hintText: 'Email', label: Text('Email')),
            ));
  }
//Método que devuelve un Padding, con el TextField del campo password.
  Widget _passwordInput() {
    //Lo mismo pero orientado al campo contraseña.
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          onChanged: ((value) => pass = value),
          decoration: const InputDecoration(
              hintText: 'Password', label: Text('Password')),
          //Propiedad obscureText, con la que podremos indicar que se va a recibir una
          //contraseña por lo tanto cada caracter será sustituido por asteriscos.
          obscureText: true,
        ));
  }
}