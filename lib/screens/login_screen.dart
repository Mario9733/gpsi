import 'package:flutter/material.dart';
import 'package:gpsi/screens/register_screen.dart';
import 'package:gpsi/screens/home_screen.dart';
import 'package:gpsi/services/authentication_service.dart';
import 'package:gpsi/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 80.0),
                Image.asset(
                  'assets/images/2.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: AppStyles.inputHintTextStyle,
                  ),
                  style: AppStyles.inputTextStyle,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo),
                  ),
                  style: TextStyle(color: Colors.indigo),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String senha = _senhaController.text;

                    // Efetua o login
                    bool loggedIn = await _authService.login(email, senha);

                    if (loggedIn) {
                      // Após o login bem-sucedido, navega para a tela inicial
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Erro de Login'),
                          content: Text('Usuário não encontrado.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Login', style: TextStyle(color: Colors.indigo, fontSize: 20)),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Ainda não tem uma conta? Cadastre-se aqui.',
                    style: TextStyle(
                      color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
