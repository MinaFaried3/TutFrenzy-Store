import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/domain/models/store_details_model.dart';
import 'package:frenzy_store/domain/repository/repository.dart';
import 'package:frenzy_store/domain/usecase/base_use_case.dart';

class GetStoreDetailsUseCase extends BaseUseCase<Void, StoreDetails> {
  final Repository _repository;

  GetStoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> call(Void input) async {
    return _repository.getStoreDetails();
  }
}
