import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpsi/screens/addpatient_screen.dart';
import 'package:gpsi/screens/home_screen.dart';
import 'package:gpsi/screens/session_list_screen.dart';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
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
            'Lista de Pacientes',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
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
                        hintText: 'Buscar paciente...',
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
                      MaterialPageRoute(builder: (context) => AddPatientScreen()),
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
                  .collection('pacientes')
                  .orderBy('name')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final patients = snapshot.data!.docs
                    .where((doc) => doc['name'].toLowerCase().contains(_searchText.toLowerCase()))
                    .toList();
                return ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (BuildContext context, int index) {
                    final patient = patients[index].data() as Map<String, dynamic>; // Obtém os dados do documento
                    final name = patient['name'] ?? 'Nome não disponível'; // Verifica se o campo 'name' existe
                    final phone = patient['phone'] ?? 'Telefone não disponível'; // Verifica se o campo 'phone' existe
                    return ListTile(
                      title: Text(
                        name.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        phone.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SessionListScreen(patientId: patients[index].id, patientName: name)),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20.0), // Adiciona espaço antes do botão "Voltar"
          TextButton(
            onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
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
    );
  }
}
