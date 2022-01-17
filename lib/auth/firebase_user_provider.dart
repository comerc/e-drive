import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EDriveFirebaseUser {
  EDriveFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

EDriveFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EDriveFirebaseUser> eDriveFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<EDriveFirebaseUser>((user) => currentUser = EDriveFirebaseUser(user));
