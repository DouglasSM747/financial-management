import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final createdUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update the username
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await createdUser.user.reload();
    return createdUser.user.uid;
  }

  // Email & Password Sign In
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      ))
          .user
          .uid;
    } catch (e) {
      return null;
    }
  }

  Future someMethod() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.email;
  }

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }
}
