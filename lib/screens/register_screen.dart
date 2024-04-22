import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo),
                  ),
                  style: TextStyle(color: Colors.indigo),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo),
                  ),
                  style: TextStyle(color: Colors.indigo),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.indigo),
                  ),
                  style: TextStyle(color: Colors.indigo),
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

                      if (userCredential.user != null) {
                        String userId = userCredential.user!.uid;

                        // Usando o e-mail como nome da coleção sem substituir os pontos
                        await _firestore.collection(email).doc('pacientes').set({});
                        await _firestore.collection(email).doc('sessoes').set({});
                        await _firestore.collection(email).doc('agenda').set({});

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Usuário cadastrado com sucesso!', style: TextStyle(color: Colors.white)),
                          ),
                        );

                        Navigator.pop(context);
                      }
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
                  child: Text('Cadastrar', style: TextStyle(color: Colors.indigo, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
