import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpsi/screens/addpatient_screen.dart';

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
              stream: FirebaseFirestore.instance.collection('patients').orderBy('name').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final patients = snapshot.data!.docs.where((doc) => doc['name'].toLowerCase().contains(_searchText.toLowerCase())).toList();
                return ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        patients[index]['name'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        patients[index]['age'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      // Implemente a lógica para ir para a tela de detalhes do paciente ao ser clicado
                      onTap: () {
                        // Implemente aqui a lógica para navegar para a tela de detalhes do paciente
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
