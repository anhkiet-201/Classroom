import 'package:class_room_chin/utils/Utils.dart';

class Classroom {
  late final String classID;
  late final String className;
  late final String tern;
  late final String description;
  late final String classOwner;
  late final String img;

  Classroom(
      {required this.className,
      required this.classID,
      this.tern = 'null',
      this.description = 'null',
      required this.classOwner,
      this.img = 'null'});

  Classroom.create(
      {required this.className,
      this.tern = 'null',
      this.description = 'null',
      required this.classOwner,
      this.img = 'null'}) {
    classID = createClassID();
  }

  Map<String, Object> toFirebaseObject() {
    return {
      'classID': classID,
      'className': className,
      'tern': tern,
      'description': description,
      'classOwner': classOwner,
      'img': img
    };
  }

  Classroom.fromMap(Map<Object?, Object?> map) {
    classID = '${map['classID']}';
    className = '${map['className']}';
    tern = '${map['tern']}';
    description = '${map['description']}';
    classOwner = '${map['classOwner']}';
  }
}
