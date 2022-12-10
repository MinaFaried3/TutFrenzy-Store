import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/data/network/requests.dart';
import 'package:frenzy_store/domain/models/forgot_password_model.dart';
import 'package:frenzy_store/domain/repository/repository.dart';
import 'package:frenzy_store/domain/usecase/base_use_case.dart';

class ForgotPasswordUseCase
    implements BaseUseCase<ForgotPasswordInput, ForgotPassword> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPassword>> execute(
      ForgotPasswordInput input) async {
    return await _repository.forgotPassword(ForgotPasswordRequest(input.email));
  }

  Future<Either<Failure, ForgotPassword>> call(
      ForgotPasswordInput input) async {
    return await _repository.forgotPassword(ForgotPasswordRequest(input.email));
  }
}

class ForgotPasswordInput extends Equatable {
  final String email;

  const ForgotPasswordInput(this.email);

  @override
  List<Object> get props => [email];
}
