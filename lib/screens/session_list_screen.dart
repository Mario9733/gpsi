import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpsi/screens/SessionDetailsScreen.dart';
import 'package:intl/intl.dart';
import 'package:gpsi/screens/add_session_screen.dart';

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
                            setState(() {
                              _searchText = _searchController.text;
                            });
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
                  .collection(FirebaseAuth.instance.currentUser!.email!) // Coleção principal com o nome do e-mail do usuário
                  .doc('sessoes')
                  .collection('sessoes') // Coleção onde as sessões estão armazenadas
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
                    final sessionData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    final patientId = sessionData['patientId'];
                    if (patientId == widget.patientId) {
                      final diagnosis = sessionData['diagnosis'];
                     
                      return ListTile(
                        title: Text(
                          diagnosis,
                          style: TextStyle(color: Colors.white),
                        ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SessionDetailsScreen(diagnosis: diagnosis),
                          ),
                        );
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
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
