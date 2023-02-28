import 'package:phone_book/constants.dart';
import 'package:phone_book/models/employee.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  // add an employee
  Future<void> add(
    String fullName,
    String phoneNumber,
    String email,
    String position,
  ) async {
    try {
      final docId = const Uuid().v1();

      if (fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          email.isNotEmpty &&
          position.isNotEmpty) {
        final Employee employee = Employee(
          docId: docId,
          companyId: auth.currentUser!.uid,
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          position: position,
        );

        await db.collection('employees').doc(docId).set(employee.toJson());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> delete(String id) async {
    await db.collection('employees').doc(id).delete();
  }
}
