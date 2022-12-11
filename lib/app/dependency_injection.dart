import 'package:dio/dio.dart';
import 'package:frenzy_store/app/app_prefs.dart';
import 'package:frenzy_store/data/data_source/remote_data_source.dart';
import 'package:frenzy_store/data/network/app_api.dart';
import 'package:frenzy_store/data/network/dio_factory.dart';
import 'package:frenzy_store/data/network/network_info.dart';
import 'package:frenzy_store/data/repository/repository_impl.dart';
import 'package:frenzy_store/domain/repository/repository.dart';
import 'package:frenzy_store/domain/usecase/forgot_password_use_case.dart';
import 'package:frenzy_store/domain/usecase/login_usecase.dart';
import 'package:frenzy_store/domain/usecase/register_use_case.dart';
import 'package:frenzy_store/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:frenzy_store/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:frenzy_store/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getItInstance = GetIt.instance;

Future<void> initAppModule() async {
  // app module it is a module where we put all generic dependencies

  // shared preference
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  getItInstance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app preference
  getItInstance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(getItInstance<SharedPreferences>()));

  // dio
  getItInstance.registerLazySingleton<DioFactory>(
      () => DioFactory(getItInstance<AppPreferences>()));
  Dio dio = await getItInstance<DioFactory>().getDio();

  //app service client
  getItInstance
      .registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // network info
  getItInstance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // remote data source
  getItInstance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getItInstance<AppServiceClient>()));

  // repository
  getItInstance.registerLazySingleton<Repository>(() => RepositoryImpl(
        getItInstance<RemoteDataSource>(),
        getItInstance<NetworkInfo>(),
      ));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    //use case
    getItInstance.registerFactory<LoginUseCase>(
        () => LoginUseCase(getItInstance<Repository>()));
    //view model
    getItInstance.registerFactory<LoginViewModel>(
        () => LoginViewModel(getItInstance<LoginUseCase>()));
  }
}

void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    //use case
    getItInstance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(getItInstance<Repository>()));
    //view model
    getItInstance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(getItInstance<ForgotPasswordUseCase>()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    //use case
    getItInstance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(getItInstance<Repository>()));
    //view model
    getItInstance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(getItInstance<RegisterUseCase>()));
  }
}
