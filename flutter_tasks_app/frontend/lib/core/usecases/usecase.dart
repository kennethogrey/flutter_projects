import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/errors/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
