import 'package:equatable/equatable.dart';

// login parameters
class LoginRequest extends Equatable {
  final String email;
  final String password;

  const LoginRequest(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// forgot password
class ForgotPasswordRequest extends Equatable {
  final String email;

  const ForgotPasswordRequest(this.email);

  @override
  List<Object> get props => [email];
}

// register parameters
class RegisterRequest extends Equatable {
  final String userName;
  final String countryMobileCode;
  final String mobileNumber;
  final String email;
  final String password;
  final String profile;

  const RegisterRequest({
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
