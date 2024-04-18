import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text('MeuPsi'),
      ),
      body: Center(
        child: Text(
          'Tela Principal',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
