import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, @required this.color
  }) : super(key: key);

  final String title;
  final Color? color;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Validando login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Image.asset('assets/images/login_image.png',
                    width: 440, height: 280),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _emailInput(),
              _passwordInput(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              MaterialButton(
                color: widget.color,
                child: Text(widget.title),
                onPressed: _boton,
              ),
            ],
            ),
        ),
      ),
       ),
    );
  }

   mostrarResultado(){
    return const AlertDialog(
      title: Text("Login realizado"),
    );
  }


  Widget _emailInput() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
            decoration:
                const InputDecoration(hintText: 'Email', label: Text('Email')),
            validator: (value) => _validarEmail(value!)));
  }

  _boton() {
    //Cuando se presione el botón
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
  }

  

  Widget _passwordInput() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: const InputDecoration(
              hintText: 'Password', label: Text('Password')),
          validator: (value) => _validarPassword(value!),
          obscureText: true,
        ));
  }

  // Widget _loginButton() {
  //   return RawMaterialButton(
  //     onPressed: () {
  //       // devolverá true si el formulario es válido, o falso si
  //       // el formulario no es válido.
  //       if (_formKey.currentState!.validate()) {
  //         // Si el formulario es válido, queremos mostrar un Snackbar
  //         Scaffold.of(context)
  //             .showSnackBar(const SnackBar(content: Text('Login correcto')));
  //       }
  //     },
  //     child: const Text('Login'),
  //   );
  // }
  String _validarEmail(String value) {
  String correo = "usuario@gmail.com";

  if (correo != value) {
    return 'El correo no es correcto';
  } else {
    return 'El correo es correcto';
  }
}

String _validarPassword(String value) {
  String password = "usuario";

  if (password != value) {
    return 'La contraseña no es correcta';
  } else {
    return 'La contraseña es correcta';
  }
}
}


