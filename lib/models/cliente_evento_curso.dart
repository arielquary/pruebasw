class ClienteEventoCurso {
  final String name;
  final String email;
  final String eventId;
  final String courseId;

  ClienteEventoCurso({
    required this.name,
    required this.email,
    required this.eventId,
    required this.courseId,
  });

  factory ClienteEventoCurso.fromJson(Map<String, dynamic> json) {
    return ClienteEventoCurso(
      name: json['name'] as String,
      email: json['email'] as String,
      eventId: json['eventId'] as String,
      courseId: json['courseId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'eventId': eventId,
      'courseId': courseId,
    };
  }
} 