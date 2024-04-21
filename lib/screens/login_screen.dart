import 'package:flutter/material.dart';
import 'package:gpsi/screens/register_screen.dart';
import 'package:gpsi/screens/home_screen.dart';
import 'package:gpsi/services/authentication_service.dart';
import 'package:gpsi/app_styles.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo, // Define a cor de fundo para azul
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 1, // 100% da largura da tela
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
                    hintStyle: AppStyles.inputHintTextStyle, // Cor do texto do hint
                  ),
                  style: AppStyles.inputTextStyle, // Cor do texto digitado
                ),
                
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo), // Cor do texto do hint
                  ),
                  style: TextStyle(color: Colors.indigo), // Cor do texto digitado
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String senha = _senhaController.text;

                    bool loggedIn = await _authService.login(email, senha);

                    if (loggedIn) {
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
                  child: Text('Login', style: TextStyle(color: Colors.indigo, fontSize: 20)), // Cor do texto do botão
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
                      color: Colors.white, fontSize: 20),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
