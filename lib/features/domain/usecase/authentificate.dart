
import '../../../../core/either/either.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../entity/authentificated_user.dart';
import '../repository/authentification.dart';

class AuthenticateUseCase
    implements Usecase<AuthenticatedUserEntity, Params> {
  final AuthenticationRepository _repository;

  AuthenticateUseCase(AuthenticationRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, AuthenticatedUserEntity>> call(Params params) async {
    if (params is GetStatusParams) {
      return _repository.getUser();
    } else if (params is LoginParams) {
      return _repository.login(params.email, params.password);
    } else if (params is SignUpParams) {
      return _repository.signUp(params.email, params.password);
    } else {
      throw UnimplementedError();
    }
  }
}

class AuthenticateUseCaseResponse {}

abstract class Params {}

class GetStatusParams extends Params {}

class LoginParams extends Params {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

}


class SignUpParams extends Params {
  final String email;
  final String password;

  SignUpParams({required this.email, required this.password});

}
