import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart';

FirebaseDatabase getDatabase() {
  FirebaseApp _app = Firebase.app();
  FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: _app, databaseURL: "https://team-randomizer-1516f-default-rtdb.europe-west1.firebasedatabase.app/");
  return database;
}
