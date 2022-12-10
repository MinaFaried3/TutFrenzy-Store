import 'package:equatable/equatable.dart';

class ForgotPassword extends Equatable {
  final String supportMessage;

  const ForgotPassword({required this.supportMessage});

  @override
  List<Object> get props => [supportMessage];
}
