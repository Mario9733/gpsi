import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo), // Cor do texto do hint
                  ),
                  style: TextStyle(color: Colors.indigo), // Cor do texto digitado
                ),

                
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo), // Cor do texto do hint
                  ),
                  style: TextStyle(color: Colors.indigo), // Cor do texto digitado
                ),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo), // Cor do texto do hint
                  ),
                  style: TextStyle(color: Colors.indigo), // Cor do texto digitado
                ),


                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text.trim();
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    try {
                      UserCredential userCredential =
                          await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Usuário cadastrado com sucesso!', style: TextStyle(color: Colors.white)),
                        ),
                      );

                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao cadastrar usuário: $e', style: TextStyle(color: Colors.white)),
                        ),
                      );
                    }
                  },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
                  child: Text('Cadastrar', style: TextStyle(color: Colors.indigo, fontSize: 18)), // Cor do texto do botão
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
