import 'package:dio/dio.dart';
import 'package:frenzy_store/data/network/failure.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';

class ErrorHandler implements Exception {
  late final Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = handleError(error);
    } else {
      failure = DataSource.defaultState.getFailure();
    }
  }
}

Failure handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.connectTimeout.getFailure();

    case DioErrorType.sendTimeout:
      return DataSource.sendTimeout.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();

    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
          error.response!.statusCode!,
          error.response!.statusMessage!,
        );
      }

      return DataSource.defaultState.getFailure();

    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();

    case DioErrorType.other:
      return DataSource.defaultState.getFailure();
  }
}

enum DataSource {
  success(
    200,
    AppStrings.success,
  ), //success with data
  noContent(
    201,
    AppStrings.success,
  ), // success with no data (no content,)
  badRequest(
    400,
    AppStrings.badRequestError,
  ), // failure, API rejected request
  forbidden(
    403,
    AppStrings.forbiddenError,
  ), //  failure, API rejected request
  unauthorized(
    401,
    AppStrings.unauthorizedError,
  ), // failure, user is not authorised
  notFound(
    404,
    AppStrings.notFoundError,
  ), // failure, not found
  internalServerError(
    500,
    AppStrings.internalServerError,
  ), // failure, crash in server side

  //local status code
  connectTimeout(
    -1,
    AppStrings.timeoutError,
  ),
  cancel(
    -2,
    AppStrings.defaultError,
  ),
  receiveTimeout(
    -3,
    AppStrings.timeoutError,
  ),
  sendTimeout(
    -4,
    AppStrings.timeoutError,
  ),
  cacheError(
    -5,
    AppStrings.cacheError,
  ),
  noInternetConnection(
    -6,
    AppStrings.noInternetError,
  ),
  defaultState(
    -7,
    AppStrings.defaultError,
  );

  final int code;
  final String message;
  const DataSource(
    this.code,
    this.message,
  );
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
          DataSource.success.code,
          DataSource.success.message,
        );

      case DataSource.noContent:
        return Failure(
          DataSource.noContent.code,
          DataSource.noContent.message,
        );

      case DataSource.badRequest:
        return Failure(
          DataSource.badRequest.code,
          DataSource.badRequest.message,
        );

      case DataSource.forbidden:
        return Failure(
          DataSource.forbidden.code,
          DataSource.forbidden.message,
        );

      case DataSource.unauthorized:
        return Failure(
          DataSource.unauthorized.code,
          DataSource.unauthorized.message,
        );

      case DataSource.notFound:
        return Failure(
          DataSource.notFound.code,
          DataSource.notFound.message,
        );

      case DataSource.internalServerError:
        return Failure(
          DataSource.internalServerError.code,
          DataSource.internalServerError.message,
        );

      case DataSource.connectTimeout:
        return Failure(
          DataSource.connectTimeout.code,
          DataSource.connectTimeout.message,
        );

      case DataSource.cancel:
        return Failure(
          DataSource.cancel.code,
          DataSource.cancel.message,
        );

      case DataSource.receiveTimeout:
        return Failure(
          DataSource.receiveTimeout.code,
          DataSource.receiveTimeout.message,
        );

      case DataSource.sendTimeout:
        return Failure(
          DataSource.sendTimeout.code,
          DataSource.sendTimeout.message,
        );

      case DataSource.cacheError:
        return Failure(
          DataSource.cacheError.code,
          DataSource.cacheError.message,
        );

      case DataSource.noInternetConnection:
        return Failure(
          DataSource.noInternetConnection.code,
          DataSource.noInternetConnection.message,
        );

      case DataSource.defaultState:
        return Failure(
          DataSource.defaultState.code,
          DataSource.defaultState.message,
        );
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
