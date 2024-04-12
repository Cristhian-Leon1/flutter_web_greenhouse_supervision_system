import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_web_greenhouse_supervision_system/views/Home.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  /// Login
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Register
  final _nameController = TextEditingController();
  final _emailRegisterController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  bool _unlockPassword = false;
  bool _rememberMe = false;
  bool _processing = false;
  bool _processingScreens1 = false;
  bool _processingScreens2 = false;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailRegisterController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }


  bool validatePassword(String password) {
    return password.length >= 8;
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    void logInPushButton() async {
      try {
        setState(() {
          _processing = true;
        });
        final url = Uri.parse('https://invernaapirest.onrender.com/api/auth/login');
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': _emailController.text,
            'password': _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final userName = responseData['data']['user']['name'];
          setState(() {
            _processing = false;
          });

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Home(nameUser: userName),
            ),
          );
        } else {
          print('Error: ${response.statusCode}');
          print('Mensaje de error: ${response.body}');
          setState(() {
            _processing = false;
          });

          if (response.statusCode == 404) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Usuario inválido'),
                  content: const Text('Correo inválido.'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
            return;
          }

          if (response.statusCode == 401) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Usuario inválido'),
                  content: const Text('Contraseña incorrecta.'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
            return;
          }
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _processing = false;
        });
      }
    }

    void registerPushButton() async {
      if (!validatePassword(_password1Controller.text)) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Contraseña inválida'),
              content: const Text('La contraseña debe tener al menos 8 caracteres.'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
      try {
        setState(() {
          _processing = true;
        });

        final url = Uri.parse('https://invernaapirest.onrender.com/api/auth/register');
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "name": _nameController.text,
            "email": _emailRegisterController.text,
            "password": _password1Controller.text
          }),
        );

        if (response.statusCode == 200) {
          setState(() {
            _processing = false;
            _nameController.text = "";
            _emailRegisterController.text = "";
            _password1Controller.text = "";
            _password1Controller.text = "";
            _processingScreens1 = false;
            _processingScreens2 = false;
          });
        } else {
          print('Error: ${response.statusCode}');
          print('Mensaje de error: ${response.body}');
          setState(() {
            _processing = false;
          });
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _processing = false;
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        body: width > 600 ? Row(
          children: [
            Expanded(
              child: Material(
                elevation: _processingScreens1 == false ? 10 : 0,
                child: Container(
                  color: _processingScreens1 == false ? Colors.green[300] : Colors.transparent,
                  child: _processingScreens1 == false ? Center(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(50,20,50,25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Bienvenido de nuevo, ingresa con tu cuenta.',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: const Color(0xfff7f7f7),
                                fontSize: width * 0.024
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Correo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 60,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.black87),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(Icons.email, color: Color(0xff073763)),
                                    hintText: 'Correo electrónico',
                                    hintStyle: TextStyle(color: Colors.black38),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contraseña',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                height: 60,
                                child: TextField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: _unlockPassword ? false : true,
                                  style: const TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(top: 14),
                                    prefixIcon: const Icon(Icons.lock, color: Color(0xff073763)),
                                    suffixIcon: IconButton(
                                      color: const Color(0xff073763),
                                      onPressed: () {
                                        setState(() {
                                          _unlockPassword = !_unlockPassword;
                                        });
                                      },
                                      icon: _unlockPassword
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(Icons.remove_red_eye_outlined),
                                    ),
                                    hintText: 'Contraseña',
                                    hintStyle: const TextStyle(color: Colors.black38),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                  onPressed: () => print("Contraseña olvidada pressed"),
                                  child: const Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: TextStyle(color: Colors.white,),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor: Colors.white,
                                      ),
                                      child: Checkbox(
                                        value: _rememberMe,
                                        checkColor: Colors.deepPurple,
                                        activeColor: Colors.white,
                                        onChanged: (value) {
                                          setState(() {
                                            _rememberMe = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text(
                                      'Recuérdame',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              _processing
                              ? Container(
                                padding: const EdgeInsets.symmetric(vertical: 25),
                                child: const Center(child: CircularProgressIndicator(color: Color(0xff073775))))
                              : Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 25),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: const Color(0xff073775),
                                  ),
                                  onPressed: logInPushButton,
                                  child: const Text(
                                    'INICIAR SESIÓN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _processingScreens1 = true;
                                    });
                                  },
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '¿No tienes una cuenta?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' Regístrate',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/escudo_62_anios.png', width: width * 0.15),
                            Image.asset('assets/logo_acreditacion.png', width: width * 0.19),
                          ],
                        ),
                        Image.asset('assets/slogan_negro.png', width: width * 0.3),
                      ],
                    ),
                  ),
                ),
              )
            ),
            Expanded(
              child: Material(
                elevation: _processingScreens1 == false ? 0 : 10,
                child: Container(
                  color: _processingScreens1 == false ? Colors.transparent : Colors.green[300],
                  child: _processingScreens1 == false
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/escudo_62_anios.png', width: width * 0.15),
                            Image.asset('assets/logo_acreditacion.png', width: width * 0.19),
                          ],
                        ),
                        Image.asset('assets/slogan_negro.png', width: width * 0.3),
                      ],
                    ),
                  )
                  : Center(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(50,20,50,25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Si no tienes una cuenta regístrate.',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: const Color(0xfff7f7f7),
                                fontSize: width * 0.025
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nombre completo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2)
                                    )
                                  ]
                                ),
                                height: 50,
                                child: TextField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(color: Colors.black87),
                                  decoration:  const InputDecoration(
                                    border:InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(Icons.person, color: Color(0xff073763)),
                                    hintText: 'Nombre de usuario',
                                    hintStyle: TextStyle(color: Colors.black38)
                                  ),
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Correo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2)
                                    )
                                  ]
                                ),
                                height:50,
                                child: TextField(
                                  controller: _emailRegisterController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.black87),
                                  decoration:  const InputDecoration(
                                    border:InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(Icons.email, color: Color(0xff073763)),
                                    hintText: 'Correo electrónico',
                                    hintStyle: TextStyle(color: Colors.black38)
                                  ),
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contraseña',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2)
                                    )
                                  ]
                                ),
                                height: 50,
                                child: TextField(
                                  controller: _password1Controller,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: const TextStyle(color: Colors.black87),
                                  decoration:  const InputDecoration(
                                    border:InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(Icons.key, color: Color(0xff073763)),
                                    hintText: 'Contraseña',
                                    hintStyle: TextStyle(color: Colors.black38)
                                  ),
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0,2)
                                )
                              ]
                            ),
                            height: 50,
                            child: TextField(
                              controller: _password2Controller,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(color: Colors.black87),
                              decoration:  const InputDecoration(
                                border:InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(Icons.key, color: Color(0xff073763)),
                                hintText: 'Confirmar contraseña',
                                hintStyle: TextStyle(color: Colors.black38)
                              ),
                            )
                          ),
                          _processing
                          ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: const Center(child: CircularProgressIndicator(color: Color(0xff073775))))
                          : Container(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                backgroundColor: const Color(0xff073775),
                              ),
                              onPressed: registerPushButton,
                              child: const Text(
                                'REGISTRARSE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _processingScreens1 = false;
                                  _emailController.text = "";
                                  _passwordController.text = "";
                                });
                              },
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '¿Ya tienes una cuenta?',
                                      style: TextStyle(
                                        color:Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                      )
                                    ),
                                    TextSpan(
                                      text: ' Inicia sesión',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ) ,
                ),
              )
            )
          ],
        ) :
        _processingScreens2 == false ? Padding(
          padding: const EdgeInsets.all(20),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(30,20,30,25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¡Ingresa con tu cuenta!',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: const Color(0xfff7f7f7),
                            fontSize:  width * 0.1
                        ),
                      ),
                      SizedBox(height: height * 0.07),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Correo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black87),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(Icons.email, color: Color(0xff073763)),
                                hintText: 'Correo electrónico',
                                hintStyle: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contraseña',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60,
                            child: TextField(
                              controller: _passwordController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: _unlockPassword ? false : true,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(top: 14),
                                prefixIcon: const Icon(Icons.lock, color: Color(0xff073763)),
                                suffixIcon: IconButton(
                                  color: const Color(0xff073763),
                                  onPressed: () {
                                    setState(() {
                                      _unlockPassword = !_unlockPassword;
                                    });
                                  },
                                  icon: _unlockPassword
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(Icons.remove_red_eye_outlined),
                                ),
                                hintText: 'Contraseña',
                                hintStyle: const TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () => print("Contraseña olvidada pressed"),
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.white,
                                  ),
                                  child: Checkbox(
                                    value: _rememberMe,
                                    checkColor: Colors.deepPurple,
                                    activeColor: Colors.white,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                  ),
                                ),
                                const Text(
                                  'Recuérdame',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _processing ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: const Center(child: CircularProgressIndicator(color: Color(0xff073775)))
                          )
                              : Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: const Color(0xff073775),
                              ),
                              onPressed: logInPushButton,
                              child: const Text(
                                'INICIAR SESIÓN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          //Ruta para registro si se da un toque en los textos de los children
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _processingScreens2 = true;
                                });
                              },
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '¿No tienes una cuenta?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Regístrate',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ) :
        Padding(
          padding: const EdgeInsets.all(20),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(30,20,30,25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '¡Regístrate para empezar!',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: const Color(0xfff7f7f7),
                            fontSize: width * 0.1
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.07),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nombre completo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0,2)
                                )
                              ]
                            ),
                            height: 50,
                            child: TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              style: const TextStyle(color: Colors.black87),
                              decoration:  const InputDecoration(
                                border:InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(Icons.person, color: Color(0xff073763)),
                                hintText: 'Nombre de usuario',
                                hintStyle: TextStyle(color: Colors.black38)
                              ),
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Correo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0,2)
                                )
                              ]
                            ),
                            height:50,
                            child: TextField(
                              controller: _emailRegisterController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black87),
                              decoration:  const InputDecoration(
                                border:InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(Icons.email, color: Color(0xff073763)),
                                hintText: 'Correo electrónico',
                                hintStyle: TextStyle(color: Colors.black38)
                              ),
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contraseña',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0,2)
                                )
                              ]
                            ),
                            height: 50,
                            child: TextField(
                              controller: _password1Controller,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(color: Colors.black87),
                              decoration:  const InputDecoration(
                                border:InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(Icons.key, color: Color(0xff073763)),
                                hintText: 'Contraseña',
                                hintStyle: TextStyle(color: Colors.black38)
                              ),
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0,2)
                            )
                          ]
                        ),
                        height: 50,
                        child: TextField(
                          controller: _password2Controller,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(color: Colors.black87),
                          decoration:  const InputDecoration(
                            border:InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14),
                            prefixIcon: Icon(Icons.key, color: Color(0xff073763)),
                            hintText: 'Confirmar contraseña',
                            hintStyle: TextStyle(color: Colors.black38)
                          ),
                        )
                      ),
                      _processing
                      ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: const Center(child: CircularProgressIndicator(color: Color(0xff073775))))
                      : Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            backgroundColor: const Color(0xff073775),
                          ),
                          onPressed: registerPushButton,
                          child: const Text(
                            'REGISTRARSE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _processingScreens2 = false;
                              _emailController.text = "";
                              _passwordController.text = "";
                            });
                          },
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: '¿Ya tienes una cuenta?',
                                  style: TextStyle(
                                    color:Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                TextSpan(
                                  text: ' Inicia sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ]
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
