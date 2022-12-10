import 'package:dio/dio.dart';
import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/data/response/forgot_password_response.dart';
import 'package:retrofit/http.dart';

import '../response/responses.dart';

part 'app_api.g.dart';

// api end points
const String customers = "/customers";
const String loginEndPoint = "$customers/login";
const String forgotPasswordEndPoint = "$customers/forgotPassword";

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(loginEndPoint)
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST(forgotPasswordEndPoint)
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);
}
