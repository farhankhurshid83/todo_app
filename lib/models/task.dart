import 'package:intl/intl.dart';

class Task {
  final String id;
  final String? name;
  final String? fatherName;
  final String? agNumber;
  final String? email;
  final String? degree;
  final String? description;
  final bool isCompleted;
  final DateTime? dueDate;
  final String? imageBase64;
  final String? semester1Cgpa;
  final String? semester2Cgpa;
  final String? semester3Cgpa;
  final String? semester4Cgpa;
  final String? semester5Cgpa;
  final String? semester6Cgpa;
  final String? phoneNumber;
  final String? address;
  final String? major;
  final String? minor;
  final String? enrollmentYear;
  final String? expectedGraduation;
  final String? advisorName;
  final String? advisorEmail;
  final String? gpa;
  final String? creditsCompleted;
  final String? creditsRemaining;
  final String? scholarshipStatus;
  final String? internshipExperience;
  final String? extracurricularActivities;

  Task({
    required this.id,
    this.name,
    this.fatherName,
    this.agNumber,
    this.email,
    this.degree,
    this.description,
    this.isCompleted = false,
    this.dueDate,
    this.imageBase64,
    this.semester1Cgpa,
    this.semester2Cgpa,
    this.semester3Cgpa,
    this.semester4Cgpa,
    this.semester5Cgpa,
    this.semester6Cgpa,
    this.phoneNumber,
    this.address,
    this.major,
    this.minor,
    this.enrollmentYear,
    this.expectedGraduation,
    this.advisorName,
    this.advisorEmail,
    this.gpa,
    this.creditsCompleted,
    this.creditsRemaining,
    this.scholarshipStatus,
    this.internshipExperience,
    this.extracurricularActivities,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fatherName': fatherName,
      'agNumber': agNumber,
      'email': email,
      'degree': degree,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': dueDate?.toIso8601String(),
      'imageBase64': imageBase64,
      'semester1Cgpa': semester1Cgpa,
      'semester2Cgpa': semester2Cgpa,
      'semester3Cgpa': semester3Cgpa,
      'semester4Cgpa': semester4Cgpa,
      'semester5Cgpa': semester5Cgpa,
      'semester6Cgpa': semester6Cgpa,
      'phoneNumber': phoneNumber,
      'address': address,
      'major': major,
      'minor': minor,
      'enrollmentYear': enrollmentYear,
      'expectedGraduation': expectedGraduation,
      'advisorName': advisorName,
      'advisorEmail': advisorEmail,
      'gpa': gpa,
      'creditsCompleted': creditsCompleted,
      'creditsRemaining': creditsRemaining,
      'scholarshipStatus': scholarshipStatus,
      'internshipExperience': internshipExperience,
      'extracurricularActivities': extracurricularActivities,
    };
  }

  factory Task.fromMap(String id, Map<String, dynamic> map) {
    return Task(
      id: id,
      name: map['name'],
      fatherName: map['fatherName'],
      agNumber: map['agNumber'],
      email: map['email'],
      degree: map['degree'],
      description: map['description'],
      isCompleted: map['isCompleted'] ?? false,
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      imageBase64: map['imageBase64'],
      semester1Cgpa: map['semester1Cgpa'],
      semester2Cgpa: map['semester2Cgpa'],
      semester3Cgpa: map['semester3Cgpa'],
      semester4Cgpa: map['semester4Cgpa'],
      semester5Cgpa: map['semester5Cgpa'],
      semester6Cgpa: map['semester6Cgpa'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      major: map['major'],
      minor: map['minor'],
      enrollmentYear: map['enrollmentYear'],
      expectedGraduation: map['expectedGraduation'],
      advisorName: map['advisorName'],
      advisorEmail: map['advisorEmail'],
      gpa: map['gpa'],
      creditsCompleted: map['creditsCompleted'],
      creditsRemaining: map['creditsRemaining'],
      scholarshipStatus: map['scholarshipStatus'],
      internshipExperience: map['internshipExperience'],
      extracurricularActivities: map['extracurricularActivities'],
    );
  }

  String get formattedDueDate {
    if (dueDate == null) return 'No due date';
    return DateFormat('MMM dd, yyyy').format(dueDate!);
  }
}