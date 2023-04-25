
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase DATABASE = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: 'https://class-room-8dddb-default-rtdb.asia-southeast1.firebasedatabase.app/');
final FirebaseAuth AUTH = FirebaseAuth.instance;