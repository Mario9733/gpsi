import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpsi/screens/SessionDetailsScreen.dart';
import 'package:gpsi/screens/add_session_screen.dart';
import 'package:gpsi/screens/patient_list_screen.dart';

class SessionListScreen extends StatefulWidget {
  final String patientId;
  final String patientName;

  const SessionListScreen({Key? key, required this.patientId, required this.patientName}) : super(key: key);

  @override
  _SessionListScreenState createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Column(
        children: [
          SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Sessões: ${widget.patientName}',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
          ),
          SizedBox(height: 20), // Espaço de 20 pixels
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Pesquisar diagnóstico...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.indigo),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white), // Ícone "+" em cor branca
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSessionScreen(patientId: widget.patientId)),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseAuth.instance.currentUser!.email!)
                  .doc('sessoes')
                  .collection('sessoes')
                  .where('patientId', isEqualTo: widget.patientId) // Filtrando pelas sessões do paciente correto
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final sessionData = snapshot.data!.docs[index];
                    final sessionName = sessionData.id;
                    final diagnosis = sessionData['diagnosis'];
                    final symptoms = sessionData['symptoms'];
                    final treatment = sessionData['treatment'];

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Text(
                          'Data: $sessionName',
                          style: TextStyle(color: Colors.indigo),
                        ),
                        subtitle: Text(
                          'Diagnóstico: $diagnosis',
                          style: TextStyle(color: Colors.indigo),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SessionDetailsScreen(
                                patientName: widget.patientName, // Passando o nome do paciente
                                document: sessionName, // Passando a data da sessão como documento
                                diagnosis: diagnosis,
                                symptoms: symptoms,
                                treatment: treatment,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20.0), // Adiciona espaço antes do botão "Sair"
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientListScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text('Sair', style: TextStyle(color: Colors.indigo, fontSize: 20)),
          ),
          SizedBox(height: 20.0), // Adiciona espaço após o botão "Sair"
        ],
      ),
    );
  }
}
