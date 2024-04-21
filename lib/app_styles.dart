import 'package:flutter/material.dart';

class AppStyles {
  // Cores
  static const Color primaryColor = Colors.indigo; // Cor primária do aplicativo
  static const Color accentColor = Colors.white; // Cor de destaque, para botões, por exemplo
  static const Color textColor = Colors.white; // Cor do texto padrão
  static const Color errorColor = Colors.red; // Cor para indicar erros

  // Tamanhos e estilos de fonte padrão
  static const double defaultFontSize = 16.0; // Tamanho de fonte padrão

  // Estilo de texto padrão
  static const TextStyle defaultTextStyle = TextStyle(
    color: textColor,
    fontSize: defaultFontSize,
  );

  // Estilo de texto para títulos
  static const TextStyle titleTextStyle = TextStyle(
    color: textColor,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  // Estilo de texto para subtítulos
  static const TextStyle subtitleTextStyle = TextStyle(
    color: textColor,
    fontSize: 18.0,
  );

  // Estilo de texto para caixas de entrada de texto
  static const TextStyle inputTextStyle = TextStyle(
    color: primaryColor, // Cor do texto digitado
  );

  // Estilo de texto para dica dentro da caixa de entrada de texto
  static const TextStyle inputHintTextStyle = TextStyle(
    color: primaryColor, // Cor do texto do hint
  );

  // Estilo de texto para erros
  static const TextStyle errorTextStyle = TextStyle(
    color: errorColor,
    fontSize: defaultFontSize,
  );

  // Estilo de botão padrão
  static final ButtonStyle defautButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: accentColor,
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    textStyle: TextStyle(
      color: primaryColor,
      fontSize: defaultFontSize,
    ),
  );
}
