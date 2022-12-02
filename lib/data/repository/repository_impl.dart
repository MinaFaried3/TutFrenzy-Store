import 'package:dartz/dartz.dart';
import 'package:frenzy_store/data/data_source/remote_data_source.dart';
import 'package:frenzy_store/data/mappers/login_mappers.dart';
import 'package:frenzy_store/data/network/error_handler.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/data/network/network_info.dart';
import 'package:frenzy_store/data/network/requests.dart';
import 'package:frenzy_store/domain/models/login_model.dart';
import 'package:frenzy_store/domain/repository/repository.dart';

import '../../app/constants.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    // check the internet connection
    if (!(await networkInfo.isConnected)) {
      return Left(DataSource.noInternetConnection.getFailure());
    }

    try {
      // get response data
      final response = await remoteDataSource.login(loginRequest);
      printK("response is ---------------------- ${response.customer}");
      // response status is 0 => success
      if (response.status == ApiInternalStatus.success) {
        return Right(response.toDomain());
      } else {
        // response status is 1 => fail
        return Left(Failure(
          ApiInternalStatus.failure,
          response.message ?? DataSource.defaultState.message,
        ));
      }
    } catch (error) {
      // error from dio
      printK("error ------------------------------------- ${error.toString()}");
      // return Left(ErrorHandler.handle(error).failure);
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
