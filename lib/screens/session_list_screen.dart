import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:gpsi/screens/add_session_screen.dart'; // Importe a tela de adicionar sessão

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
          Text(
            'Sessões: ${widget.patientName}',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          SizedBox(height: 20),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchText = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Buscar sessão...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.indigo),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            style: TextStyle(color: Colors.indigo),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.indigo),
                          onPressed: () {
                            // Implemente a lógica de busca
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSessionScreen(patientId: widget.patientId),
                      ),
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
                  .doc('pacientes')
                  .collection('sessions')
                  .doc(widget.patientId)
                  .collection('sessions')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final sessions = snapshot.data!.docs
                    .where((doc) => DateFormat('dd/MM/yyyy').format((doc['date'] as Timestamp).toDate()).contains(_searchText))
                    .toList();
                return ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final session = sessions[index].data() as Map<String, dynamic>;
                    final sessionDate = DateFormat('dd/MM/yyyy').format((session['date'] as Timestamp).toDate());
                    return ListTile(
                      title: Text(
                        sessionDate,
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Implementar lógica para ir para a tela de detalhes da sessão
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
