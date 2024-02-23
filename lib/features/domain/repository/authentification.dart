
import '../../../../core/either/either.dart';
import '../../../core/failure/failure.dart';
import '../entity/authentificated_user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticatedUserEntity>> getUser();

  Future<Either<Failure, AuthenticatedUserEntity>> login (String email, String paswsword);

  Future<Either<Failure, void>>logout();

  Future<Either<Failure,AuthenticatedUserEntity >> signUp(String email, String password);
}