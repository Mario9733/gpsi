class Session {
  final String id;
  final String patientId;
  final String therapistId;
  final DateTime date;
  final String description;

  Session({required this.id, required this.patientId, required this.therapistId, required this.date, required this.description});
}
