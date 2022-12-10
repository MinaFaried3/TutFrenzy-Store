import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/app/extension.dart';
import 'package:frenzy_store/data/response/forgot_password_response.dart';
import 'package:frenzy_store/domain/models/forgot_password_model.dart';

extension ForgetPasswordMappers on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(
        supportMessage: this?.supportMessage.orEmpty() ?? Constants.empty);
  }
}
