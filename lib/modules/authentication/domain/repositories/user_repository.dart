import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/user_dto.dart';
import '../models/user.dart';

//https://github.com/mojaloop/contrib-pisp-demo-ui/blob/159e00af982d4cdc217d5539ab4897cb7dd9bb90/lib/repositories/firebase/account_repository.dart#L21

abstract class UserRepository {
  void createUser(User User);

  void editUser(User User);

  void Function() listenUsers(onValue(List<User> list));

  Future<List<User>> getUser(String authenticationId);
}

class UserRepositoryImpl extends UserRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> createUser(User input) async {
    UserDTO dto = UserDTO(
      id: input.id,
      authenticationId: input.authenticationId,
      name: input.name,
    );

    _db
        .collection("users")
        .add(dto.toJson())
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  void editUser(User User) {
    // TODO: implement editUser
  }

  @override
  void Function() listenUsers(onValue(List<User> list)) {
    final subscription = _db.collection("Users").snapshots().listen((event) {
      final result = event.docs.map(
        (doc) {
          UserDTO userDTO = UserDTO.fromJson(doc.data());
          return User(
            id: userDTO.id,
            authenticationId: userDTO.authenticationId,
            name: userDTO.name,
          );
        },
      );

      onValue.call(result.toList());
    });

    return () => subscription.cancel();
  }

  @override
  Future<List<User>> getUser(String authenticationId) async {
    final value = await _db.collection("users").where("authenticationId", isEqualTo: authenticationId).get();
    return value.docs.map((doc) {
      UserDTO dto = UserDTO.fromJson(doc.data());
      return User(
        id: dto.id,
        authenticationId: dto.authenticationId,
        name: dto.name,
      );
    }).toList();
  }
}
