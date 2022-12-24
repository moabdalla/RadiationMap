import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RadiationMapFirebaseUser {
  RadiationMapFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

RadiationMapFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<RadiationMapFirebaseUser> radiationMapFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<RadiationMapFirebaseUser>(
      (user) {
        currentUser = RadiationMapFirebaseUser(user);
        return currentUser!;
      },
    );
