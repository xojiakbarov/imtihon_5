
import '../../../core/either/either.dart';
import '../../../core/exception/exception.dart';
import '../../../core/failure/failure.dart';
import '../../domain/entity/authentificated_user.dart';
import '../../domain/repository/authentification.dart';
import '../data_source/remote.dart';
import '../models/authentificated_user.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _dataSource;

  const AuthenticationRepositoryImpl(
      {required AuthenticationRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, AuthenticatedUserEntity>> getUser() async {
    try {
      final user = await _dataSource.getUser();
      return Right(AuthenticatedUserModel.fromFirebaseUser(user));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.errorMassege, code: error.errorCode));
    }
  }

  @override
  Future<Either<Failure, AuthenticatedUserEntity>> login(
      String email, String password) async {
    try {
      final user = await _dataSource.login(email, password);
      return Right(AuthenticatedUserModel.fromFirebaseUser(user));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.errorMassege, code: error.errorCode));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final response = await _dataSource.logout();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.errorMassege, code: error.errorCode));
    }
  }

  @override
  Future<Either<Failure, AuthenticatedUserEntity>> signUp(
      String email, String password) async {
    try {
      final user = await _dataSource.signUp(email, password);
      return Right(AuthenticatedUserModel.fromFirebaseUser(user));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.errorMassege, code: error.errorCode));
    }
  }

}
