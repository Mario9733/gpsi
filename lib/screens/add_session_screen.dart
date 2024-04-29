import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:gpsi/models/session.dart';
import 'package:gpsi/app_styles.dart';

class AddSessionScreen extends StatefulWidget {
  final String patientId;

  const AddSessionScreen({Key? key, required this.patientId}) : super(key: key);

  @override
  _AddSessionScreenState createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  TextEditingController _symptomsController = TextEditingController();
  TextEditingController _diagnosisController = TextEditingController();
  TextEditingController _treatmentController = TextEditingController();
  TextEditingController _nextSessionDateController = TextEditingController();
  TextEditingController _nextSessionTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo, // Fundo indigo
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Adicionar Sessão',
              style: AppStyles.titleTextStyle,
            ),
            SizedBox(height: 20), // Espaçamento
            TextFormField(
              controller: _symptomsController,
              decoration: InputDecoration(
                labelText: 'Sintomas',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
              style: TextStyle(color: Colors.white), // Cor branca para o texto
              maxLines: null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _diagnosisController,
              decoration: InputDecoration(
                labelText: 'Diagnóstico',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
              style: TextStyle(color: Colors.white),
              maxLines: null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _treatmentController,
              decoration: InputDecoration(
                labelText: 'Tratamento',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
              style: TextStyle(color: Colors.white),
              maxLines: null,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nextSessionDateController,
                    decoration: InputDecoration(
                      labelText: 'Próxima sessão (Data)',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.white),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _nextSessionDateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _nextSessionTimeController,
                    decoration: InputDecoration(
                      labelText: 'Hora',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.white),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _nextSessionTimeController.text = selectedTime.format(context);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveSession,
                child: Text(
                  'Salvar Sessão',
                  style: TextStyle(color: AppStyles.primaryColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
              ),
            ),
            SizedBox(height: 20.0), // Adiciona espaço antes do botão "Voltar"
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Text(
                    'Voltar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0), // Adiciona espaço após o botão "Voltar"
          ],
        ),
      ),
    );
  }

  void _saveSession() async {
    String symptoms = _symptomsController.text.trim();
    String diagnosis = _diagnosisController.text.trim();
    String treatment = _treatmentController.text.trim();
    String nextSessionDate = _nextSessionDateController.text.trim();
    String nextSessionTime = _nextSessionTimeController.text.trim();

    // Verifica se todos os campos foram preenchidos
    if (symptoms.isEmpty || diagnosis.isEmpty || treatment.isEmpty || nextSessionDate.isEmpty || nextSessionTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
        ),
      );
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Criar a nova sessão
        Session newSession = Session(
          symptoms: symptoms,
          diagnosis: diagnosis,
          treatment: treatment,
          nextSessionDate: DateFormat('dd/MM/yyyy').parse(nextSessionDate),
          nextSessionTime: TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(nextSessionTime)),
        );

        // Formatando a data para usar como parte do ID do documento
        String formattedDate = DateFormat('yyyyMMdd').format(newSession.nextSessionDate);

        // Obtendo a quantidade atual de documentos na subcoleção "sessoes"
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(user.email!)
            .doc('sessoes')
            .collection('sessoes')
            .get();

        int docCount = querySnapshot.docs.length;

        // Formatar o ID da sessão
        String documentId = formattedDate + (docCount + 1).toString().padLeft(2, '0');

        // Salvar a sessão no Firebase Firestore
        await FirebaseFirestore.instance
            .collection(user.email!)
            .doc('sessoes') // Utilizando o ID do paciente como documento base
            .collection('sessoes')
            .doc(documentId)
            .set({
              'patientId': widget.patientId, // Adiciona o ID do paciente na sessão
              'symptoms': symptoms,
              'diagnosis': diagnosis,
              'treatment': treatment,
              'nextSessionDate': Timestamp.fromDate(newSession.nextSessionDate),
              'nextSessionTime': nextSessionTime,
              'nextSessionTimeHour': newSession.nextSessionTime.hour,
              'nextSessionTimeMinute': newSession.nextSessionTime.minute,
            });

        // Exibir mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sessão salva com sucesso.'),
          ),
        );

        // Limpar os campos
        _symptomsController.clear();
        _diagnosisController.clear();
        _treatmentController.clear();
        _nextSessionDateController.clear();
        _nextSessionTimeController.clear();

        // Retornar para a tela anterior
        Navigator.pop(context);
      } else {
        print('Erro: Sessão não salva.');
      }
    } catch (error) {
      print('Erro ao salvar a sessão: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar a sessão. Por favor, tente novamente.'),
        ),
      );
    }
  }
}
