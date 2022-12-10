import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/data/network/requests.dart';
import 'package:frenzy_store/domain/models/login_model.dart';
import 'package:frenzy_store/domain/repository/repository.dart';
import 'package:frenzy_store/domain/usecase/base_use_case.dart';

class RegisterUseCase extends BaseUseCase<RegisterInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> call(RegisterInput input) async {
    return await _repository.register(RegisterRequest(
        userName: input.userName,
        countryMobileCode: input.countryMobileCode,
        mobileNumber: input.mobileNumber,
        email: input.email,
        password: input.password,
        profile: input.profile));
  }
}

class RegisterInput extends Equatable {
  final String userName;
  final String countryMobileCode;
  final String mobileNumber;
  final String email;
  final String password;
  final String profile;

  const RegisterInput({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profile,
  });

  @override
  List<Object> get props => [
        userName,
        countryMobileCode,
        mobileNumber,
        email,
        password,
        profile,
      ];
}
