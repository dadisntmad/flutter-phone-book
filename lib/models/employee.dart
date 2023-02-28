import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String docId;
  final String companyId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String position;

  Employee({
    required this.docId,
    required this.companyId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.position,
  });

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'companyId': companyId,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email': email,
        'position': position,
      };

  static Employee fromSnap(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return Employee(
      docId: snap['docId'],
      companyId: snap['companyId'],
      fullName: snap['fullName'],
      phoneNumber: snap['phoneNumber'],
      email: snap['email'],
      position: snap['position'],
    );
  }
}
