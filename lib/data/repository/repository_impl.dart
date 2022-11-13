import 'package:dartz/dartz.dart';
import 'package:frenzy_store/data/data_source/remote_data_source.dart';
import 'package:frenzy_store/data/mappers/login_mappers.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/data/network/network_info.dart';
import 'package:frenzy_store/data/network/requests.dart';
import 'package:frenzy_store/domain/models/login_model.dart';
import 'package:frenzy_store/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(Failure(501, "please check your internet connection"));
    }

    final response = await remoteDataSource.login(loginRequest);

    if (response.status == 0) {
      return Right(response.toDomain());
    } else {
      return Left(Failure(409, response.message ?? "business error message"));
    }
  }
}
