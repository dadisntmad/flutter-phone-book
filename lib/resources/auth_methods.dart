import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_book/constants.dart';
import 'package:phone_book/models/company.dart';

class AuthMethods {
  // sign up
  Future<String> signUp(String email, String password) async {
    String response = 'Error';
    try {
      if (email.isEmpty || password.isEmpty) {
        response = 'Please fill all the required fields';
      } else {
        final UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final Company company = Company(id: cred.user!.uid, email: email);

        await db
            .collection('companies')
            .doc(cred.user?.uid)
            .set(company.toJson());
      }

      response = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        response = 'The account already exists for that email.';
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  // sign in
  Future<String> signIn(String email, String password) async {
    String response = 'Error';
    try {
      if (email.isEmpty || password.isEmpty) {
        response = 'Please fill all the required fields';
      } else {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        response = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        response = 'Wrong password provided for that user.';
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  // sign out
  Future<void> signOut() async {
    await auth.signOut();
  }
}
