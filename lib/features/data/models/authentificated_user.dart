import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entity/authentificated_user.dart';

class AuthenticatedUserModel extends AuthenticatedUserEntity {
  AuthenticatedUserModel({required super.email});

  factory AuthenticatedUserModel.fromFirebaseUser(User user) {
    return AuthenticatedUserModel(email: user.email ?? "");
  }
}
