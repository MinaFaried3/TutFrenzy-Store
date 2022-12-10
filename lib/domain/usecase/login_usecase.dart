import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/data/network/requests.dart';
import 'package:frenzy_store/domain/models/login_model.dart';
import 'package:frenzy_store/domain/repository/repository.dart';
import 'package:frenzy_store/domain/usecase/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;

  const LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> call(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput extends Equatable {
  final String email;
  final String password;

  const LoginUseCaseInput(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
