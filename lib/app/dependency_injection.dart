import 'package:dio/dio.dart';
import 'package:frenzy_store/app/app_prefs.dart';
import 'package:frenzy_store/data/data_source/remote_data_source.dart';
import 'package:frenzy_store/data/network/app_api.dart';
import 'package:frenzy_store/data/network/dio_factory.dart';
import 'package:frenzy_store/data/network/network_info.dart';
import 'package:frenzy_store/data/repository/repository_impl.dart';
import 'package:frenzy_store/domain/repository/repository.dart';
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

Future<void> initLoginModule() async {}
