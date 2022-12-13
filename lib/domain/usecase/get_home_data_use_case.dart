import 'package:dartz/dartz.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/domain/models/home_model.dart';
import 'package:frenzy_store/domain/repository/repository.dart';
import 'package:frenzy_store/domain/usecase/base_use_case.dart';

class GetHomeUseCase extends BaseUseCase<void, Home> {
  final Repository _repository;

  GetHomeUseCase(this._repository);

  @override
  Future<Either<Failure, Home>> call(void input) async {
    return await _repository.getHomeData();
  }
}
