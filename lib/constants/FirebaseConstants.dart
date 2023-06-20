
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseDatabase DATABASE = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: 'https://class-room-8dddb-default-rtdb.asia-southeast1.firebasedatabase.app/');
final FirebaseAuth AUTH = FirebaseAuth.instance;
final FirebaseStorage STORAGE = FirebaseStorage.instanceFor(app: Firebase.app(),bucket: 'gs://class-room-8dddb.appspot.com');