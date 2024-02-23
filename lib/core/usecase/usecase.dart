

import '../either/either.dart';
import '../failure/failure.dart';

abstract class Usecase<Type, Params> {
  const Usecase();

  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {

}