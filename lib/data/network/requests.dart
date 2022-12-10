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
