import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpsi/models/patient.dart';
import 'package:gpsi/models/session.dart';
import 'package:gpsi/models/agendamento.dart'; // Importação corrigida


class Agendamento {
  final String id;
  final String idPaciente; // Corrigido o nome do campo
  final DateTime date; // Corrigido o nome do campo

  Agendamento({required this.id, required this.idPaciente, required this.date}); // Corrigido o nome do parâmetro

  // Método factory para criar um objeto Agendamento a partir de um documento Firestore
  factory Agendamento.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Agendamento(
      id: doc.id,
      idPaciente: data['idPaciente'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para agendar uma nova sessão
  Future<void> scheduleAgendamento(Agendamento agendamento) async {
    try {
      await _db.collection('agendamentos').add({
        'idPaciente': agendamento.idPaciente,
        'date': agendamento.date,
      });
    } catch (e) {
      print('Erro ao agendar sessão: $e');
    }
  }

  // Método para obter a agenda de um terapeuta
  Stream<List<Agendamento>> getTherapistAgendamentos(String therapistId) {
    return _db.collection('agendamentos').where('therapistId', isEqualTo: therapistId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Agendamento.fromFirestore(doc); // Usar método factory para criar objetos Agendamento
      }).toList();
    });
  }
}
