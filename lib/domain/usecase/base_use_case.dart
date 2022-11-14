import 'package:dartz/dartz.dart';
import 'package:frenzy_store/data/network/failure.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure, Output>> execute(Input input);
}
