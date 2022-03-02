# Componente Login

Este componente realizado en flutter, dependerá de la función
que le quiera dar el usuario ya que se ha pasado una función
que se aplica a un botón, este botón lo que realiza es 
comprobar que los campos del formulario son correctos. Para
ello se ha realizado una interfaz simulando la pantalla
de logeo de una aplicación.

## Uso

El uso de este widget es sencillo, simplemente se le pasará
al botón una función de tipo botón, para ello se ha declarado
una propiedad de la clase GestureTapCallback, la función
se añade en la propiedad onPressed de cualquier botón, de
la siguiente forma:

 MaterialButton(
                color: Colors.white,
                child: const Text('Entrar'),
                onPressed: onPressed),
                )

Una vez se ha añadido la función, en el fichero en el que
se va a importar el componente, se crea la función que en
este caso valida los campos:

_validarLogin(String? email, String? pass) {
  String correo = "usuario@gmail.com";
  String password = "usuario";

  if(email != correo && pass != password){
    return _mensajeInformativo('Error', 'Los datos son incorrectos');
  }
  else {
    return _mensajeInformativo('Login completado', 'Credenciales correctas');

  }
La función _mensajeInformativo, retorna un Alert Dialog dando un
mensaje informativo del login.

Y por último se llama al componente dentro de un State y su método
sobreescrito build, creando a su vez un estado, que no cambiará ya
que el logeo de formularios tomad el foco y sus propiedades de email 
y password, que han sido validadas:

 Widget build(BuildContext context) {
    return LoginButton(onPressed: (() => _validarLogin(LoginButton.email, LoginButton.pass)),
    );
 }

 Por último se llamará a clase que contiene el componente con la validación hecha
 llamada Estado, en el método sobreescrito build en un StatelessWidget, haciendo dinámica la función:

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Componente login',
        theme: ThemeData(),
        home: const Estado(),
        );
  }

## Campos de formulario

Los campos del formulario son email y password, en el campo email no se necesita ocultar el valor que contiene el TextFormField, en el caso de la password, si
para ello el campo de email quedaría así:
Widget _emailInput() {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          onChanged: ((value) => email = value),
            decoration: const InputDecoration(hintText: 'Email', label: Text('Email')),
            ));
  }

Y el campo de contraseña que quedaría de la siguiente forma:
  Widget _passwordInput() {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          onChanged: ((value) => pass = value),
          decoration: const InputDecoration(
              hintText: 'Password', label: Text('Password')),
          obscureText: true,
        ));
  }

Para la contraseña se añade la propiedad obscureText, para ocultar
el valor de la contraseña introducido por el usuario.