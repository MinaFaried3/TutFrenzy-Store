import 'package:dartz/dartz.dart';
import 'package:frenzy_store/data/network/requests.dart';
import 'package:frenzy_store/domain/models/forgot_password_model.dart';
import 'package:frenzy_store/domain/models/home_model.dart';
import 'package:frenzy_store/domain/models/login_model.dart';
import 'package:frenzy_store/domain/models/store_details_model.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, ForgotPassword>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);

  Future<Either<Failure, Home>> getHomeData();

  Future<Either<Failure, StoreDetails>> getStoreDetails();
}
