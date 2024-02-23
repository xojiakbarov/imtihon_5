import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/exception/exception.dart';

abstract class AuthenticationRemoteDataSource {
  Future<User> getUser();

  Future<User> login(String email, String password);

  Future<void> logout();

  Future<User> signUp(String email, String password);

  factory AuthenticationRemoteDataSource() =>
      _AuthenticationRemoteDataSourceImpl();
}

class _AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  @override
  Future<User> getUser() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      if (FirebaseAuth.instance.currentUser == null) {
        throw ServerException(
          errorMassege: "User is Null",
          errorCode: 140,
        );
      }
      return FirebaseAuth.instance.currentUser!;
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await getUser();
    } on ServerException {
      rethrow;
    } catch (error) {
      throw ServerException(
        errorMassege: "$error",
        errorCode: 500,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw ServerException(
        errorMassege: "Cannot logout the user",
        errorCode: 500,
      );
    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return FirebaseAuth.instance.currentUser!;
    } on ServerException {
      rethrow;
    } catch (error) {
      throw ServerException(
        errorMassege: "$error",
        errorCode: 500,
      );
    }
  }
}
