import 'dart:async';

import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/domain/usecase/login_usecase.dart';
import 'package:frenzy_store/presentation/base/base_view_model.dart';
import 'package:frenzy_store/presentation/common/freezed_data_class.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController _showHidePasswordStreamController =
      StreamController<bool>.broadcast();

  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  /// base
  @override
  void start() {
    //show content state
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    _showHidePasswordStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  /// inputs
  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get inputShowHidePassword => _showHidePasswordStreamController.sink;

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  void setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
  }

  bool show = false;
  @override
  void showHidePassword() {
    inputShowHidePassword.add(show);
    show = !show;
  }

  @override
  Future<void> login() async {
    //1 - start loading popup state
    inputState.add(
        const LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    //2 - getting the data
    final result = await _loginUseCase
        .execute(LoginUseCaseInput(loginObject.userName, loginObject.password));
    //3- final result
    result.fold((failure) {
      //show error state
      printK("failure is here {{{ ${failure.message} }}}");
      inputState.add(ErrorState(
          stateRenderType: StateRenderType.popupErrorState,
          message: failure.message));
    }, (data) {
      printK("data is here {{{ ${data.contacts} }}}");
      inputState.add(SuccessState(
          stateRenderType: StateRenderType.popupSuccessState,
          message: "welcome ${data.customer?.name ?? ""}"));

      //4- navigate to main screen
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  ///outputs
  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isValidUserName(userName));

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isValidPassword(password));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outputShowHidePassword =>
      _showHidePasswordStreamController.stream.map((event) => event);

  /// login private functions
  bool _isValidPassword(String password) {
    return password.isNotEmpty;
  }

  bool _isValidUserName(String userName) {
    return userName.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isValidUserName(loginObject.userName) &&
        _isValidPassword(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  void setUserName(String userName);
  void setPassword(String password);
  void showHidePassword();
  Future<void> login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
  Sink get inputShowHidePassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outputAreAllInputsValid;
  Stream<bool> get outputShowHidePassword;
}
