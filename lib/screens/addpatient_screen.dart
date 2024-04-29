import 'package:flutter/material.dart';
import 'package:gpsi/models/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpsi/app_styles.dart';
import 'package:gpsi/screens/patient_list_screen.dart';
import 'package:intl/intl.dart';

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _healthPlanController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            Text(
              'Adicionar Paciente',
              style: AppStyles.titleTextStyle,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Nome Completo',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome completo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _fatherNameController,
                      decoration: InputDecoration(
                        hintText: 'Nome do Pai',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _motherNameController,
                      decoration: InputDecoration(
                        hintText: 'Nome da Mãe',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _cpfController,
                      decoration: InputDecoration(
                        hintText: 'CPF',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        hintText: 'Data de Nascimento',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: 'Telefone',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _healthPlanController,
                      decoration: InputDecoration(
                        hintText: 'Plano de Saúde',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _bloodTypeController,
                      decoration: InputDecoration(
                        hintText: 'Tipo Sanguíneo',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: 'Endereço',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: AppStyles.inputHintTextStyle,
                      ),
                      style: AppStyles.inputTextStyle,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o e-mail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _addPatient,
                          child: Text(
                            'Adicionar Paciente',
                            style: TextStyle(
                              color: AppStyles.primaryColor,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          ),
                        ),
                        ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PatientListScreen()), // Direciona para a tela home
                          );
                        },
                          child: Text(
                            'Voltar',
                            style: TextStyle(
                              color: AppStyles.primaryColor,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addPatient() async {
    if (_formKey.currentState!.validate()) {
      // Obtendo os valores dos campos de texto
      String name = _nameController.text.trim();
      String fatherName = _fatherNameController.text.trim();
      String motherName = _motherNameController.text.trim();
      String cpf = _cpfController.text.trim();
      String dob = _dobController.text.trim();
      String phone = _phoneController.text.trim();
      String healthPlan = _healthPlanController.text.trim();
      String bloodType = _bloodTypeController.text.trim();
      String address = _addressController.text.trim();
      String email = _emailController.text.trim();

      // Adicionando o paciente ao Firebase Firestore
      Patient newPatient = Patient(
        name: name,
        fatherName: fatherName,
        motherName: motherName,
        cpf: cpf,
        dob: dob,
        phone: phone,
        healthPlan: healthPlan,
        bloodType: bloodType,
        address: address,
        email: email,
      );

      // Adicionando ao Firebase Firestore
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Formatando a data para usar como parte do ID do documento
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('yyyyMMdd').format(now);

          // Obtendo a quantidade atual de documentos na subcoleção "pacientes"
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection(user.email!) // Usando o e-mail do usuário como nome da coleção
              .doc('pacientes') // Acessando a subcoleção "pacientes"
              .collection('pacientes') // Criando uma subcoleção dentro de "pacientes"
              .get();

          int docCount = querySnapshot.docs.length;

          // Criando o ID do documento no formato "anomesdia01", "anomesdia02", etc.
          String documentId = formattedDate + (docCount + 1).toString().padLeft(2, '0');

          // Adicionando o paciente à subcoleção "pacientes" dentro da coleção com o nome do e-mail do usuário
          await FirebaseFirestore.instance
              .collection(user.email!) // Usando o e-mail do usuário como nome da coleção
              .doc('pacientes') // Acessando a subcoleção "pacientes"
              .collection('pacientes') // Criando uma subcoleção dentro de "pacientes"
              .doc(documentId) // Usando o ID do documento
              .set(newPatient.toJson()); // Adicionando o paciente como um novo documento

          print('Paciente adicionado com sucesso!');
          Navigator.pop(context);
        } else {
          print('Erro: Usuário não autenticado.');
        }
      } catch (e) {
        print('Erro ao adicionar paciente: $e');
      }
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddPatientScreen(),
    );
  }
}
