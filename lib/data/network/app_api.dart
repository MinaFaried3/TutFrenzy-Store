import 'package:dio/dio.dart';
import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/data/response/forgot_password_response.dart';
import 'package:frenzy_store/data/response/home_response.dart';
import 'package:retrofit/http.dart';

import '../response/responses.dart';

part 'app_api.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

// api end points
const String customers = "/customers";
const String loginEndPoint = "$customers/login";
const String forgotPasswordEndPoint = "$customers/forgotPassword";
const String registerEndPoint = "$customers/register";
const String homeEndPoint = "/home";

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(loginEndPoint)
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST(forgotPasswordEndPoint)
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST(registerEndPoint)
  Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profile,
  );

  @GET(homeEndPoint)
  Future<HomeDataResponse> homeData();
}
