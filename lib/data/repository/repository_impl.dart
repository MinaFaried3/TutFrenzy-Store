import 'package:dartz/dartz.dart';
import 'package:frenzy_store/data/data_source/local_data_source.dart';
import 'package:frenzy_store/data/data_source/remote_data_source.dart';
import 'package:frenzy_store/data/mappers/forgot_password_mappers.dart';
import 'package:frenzy_store/data/mappers/home_mappers.dart';
import 'package:frenzy_store/data/mappers/login_mappers.dart';
import 'package:frenzy_store/data/mappers/store_details_mappers.dart';
import 'package:frenzy_store/data/network/error_handler.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/data/network/network_info.dart';
import 'package:frenzy_store/data/network/requests.dart';
import 'package:frenzy_store/domain/models/forgot_password_model.dart';
import 'package:frenzy_store/domain/models/home_model.dart';
import 'package:frenzy_store/domain/models/login_model.dart';
import 'package:frenzy_store/domain/models/store_details_model.dart';

import '../../app/constants.dart';
import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    // check the internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSource.noInternetConnection.getFailure());
    }

    try {
      // get response data
      final response = await _remoteDataSource.login(loginRequest);
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
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ForgotPassword>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    // check the internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSource.noInternetConnection.getFailure());
    }

    try {
      final response =
          await _remoteDataSource.forgotPassword(forgotPasswordRequest);

      if (response.status == ApiInternalStatus.success) {
        return Right(response.toDomain());
      }

      return Left(Failure(
        ApiInternalStatus.failure,
        response.message ?? DataSource.defaultState.message,
      ));
    } catch (error) {
      // error from dio
      printK("error ------------------------------------- ${error.toString()}");
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    // check the internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSource.noInternetConnection.getFailure());
    }

    try {
      // get response data
      final response = await _remoteDataSource.register(registerRequest);
      printK("response is ---------------------- ${response.customer?.name}");
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
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Home>> getHomeData() async {
    try {
      // get cached response data
      final response = await _localDataSource.getHomeData();
      printK(
          " ====================== GET DATA FROM CACHE ====================");
      return Right(response.toDomain());
    } catch (cacheError) {
      //cache data is not exist or valid
      // get from remote data source
      // check the internet connection
      printK(ErrorHandler.handle(cacheError).failure.message);
      if (!(await _networkInfo.isConnected)) {
        return Left(DataSource.noInternetConnection.getFailure());
      }

      try {
        // get response data
        final response = await _remoteDataSource.getHomeData();
        printK(
            "response is ---------------------- ${response.data?.stores?.first.title}");
        // response status is 0 => success
        if (response.status == ApiInternalStatus.success) {
          _localDataSource.saveHomeDataToCache(response); //save to cache

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
        printK(
            "error ------------------------------------- ${error.toString()}");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    try {
      // get cached response data
      final response = await _localDataSource.getStoreDetails();
      printK(
          " ====================== GET DATA FROM CACHE ====================");
      return Right(response.toDomain());
    } catch (cacheError) {
      //cache data is not exist or valid
      // get from remote data source
      // check the internet connection
      printK(ErrorHandler.handle(cacheError).failure.message);
      if (!(await _networkInfo.isConnected)) {
        return Left(DataSource.noInternetConnection.getFailure());
      }

      try {
        // get response data
        final response = await _remoteDataSource.getStoreDetails();
        printK("response is ---------------------- ${response.title}");
        // response status is 0 => success
        if (response.status == ApiInternalStatus.success) {
          _localDataSource.saveStoreDetailsToCache(response); //save to cache

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
        printK(
            "error ------------------------------------- ${error.toString()}");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
  }
}
