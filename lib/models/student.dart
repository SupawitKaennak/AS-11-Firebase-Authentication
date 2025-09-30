class Student {
  final int? id;
  final String studentId;
  final String firstName;
  final String lastName;
  final String program;
  final String eventName;

  Student({
    this.id,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.program,
    required this.eventName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'program': program,
      'eventName': eventName,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      studentId: map['studentId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      program: map['program'],
      eventName: map['eventName'],
    );
  }
}
