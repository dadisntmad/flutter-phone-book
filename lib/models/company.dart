import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  final String id;
  final String email;

  Company({
    required this.id,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
      };

  static Company fromSnap(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return Company(
      id: snap['id'],
      email: snap['email'],
    );
  }
}
