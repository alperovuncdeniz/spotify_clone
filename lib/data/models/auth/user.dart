// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:spotify_clone/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageUrl;

  UserModel({
    this.fullName,
    this.email,
    this.imageUrl,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
    imageUrl = data['duration'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      fullName: fullName,
    );
  }
}
