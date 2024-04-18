import 'package:flutter/material.dart';
import 'package:gpsi/screens/register_screen.dart';
import 'package:gpsi/screens/home_screen.dart';
import 'package:gpsi/services/authentication_service.dart';
import 'package:gpsi/services/database_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GPsi', // Adicionando o nome do aplicativo no topo da tela
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(
                hintText: 'Senha',
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text;
                String senha = _senhaController.text;

                // Chame o método login da classe AuthenticationService
                bool loggedIn = await _authService.login(email, senha);

                if (loggedIn) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  // Mostra uma mensagem de erro caso o login falhe
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
              child: Text('Login'),
            ),
            SizedBox(height: 20.0),

            TextButton(
              onPressed: () {
                // Navegue para a tela de cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text(
                'Ainda não tem uma conta? Cadastre-se aqui.', // Alterando cor do texto para branco
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
