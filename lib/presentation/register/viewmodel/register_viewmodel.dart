import 'dart:async';
import 'dart:io';

import 'package:frenzy_store/app/functions.dart';
import 'package:frenzy_store/domain/usecase/register_use_case.dart';
import 'package:frenzy_store/presentation/base/base_view_model.dart';
import 'package:frenzy_store/presentation/common/freezed_data_class.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterInputs, RegisterOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _countryMobileCodeStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profileStreamController =
      StreamController<File>.broadcast();
  final StreamController _showHidePasswordStreamController =
      StreamController<bool>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController isUserRegisteredSuccessfullyStreamController =
      StreamController<bool>();

  RegisterObject registerObject = RegisterObject(
      userName: '',
      countryMobileCode: '',
      mobileNumber: '',
      email: '',
      password: '',
      profile: '');

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  ///base view model
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _countryMobileCodeStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profileStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();
  }

  /// inputs sink
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get inputCountryMobileCode => _countryMobileCodeStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfile => _profileStreamController.sink;

  @override
  Sink get inputShowHidePassword => _showHidePasswordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  /// outputs stream
  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outputIsCountryMobileCode =>
      _countryMobileCodeStreamController.stream
          .map((code) => _isValidMobileCode(code));

  @override
  Stream<bool> get outputIsEmail =>
      _emailStreamController.stream.map((email) => _isValidEmail(email));
  @override
  Stream<String?> get outputErrorEmail => outputIsEmail
      .map((isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<bool> get outputIsMobileNumber => _mobileNumberStreamController.stream
      .map((number) => _isValidMobileNumber(number));
  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumber.map((isMobileNumber) =>
          isMobileNumber ? null : AppStrings.mobileNumberInvalid);

  @override
  Stream<bool> get outputIsPassword => _passwordStreamController.stream
      .map((password) => _isValidPassword(password));
  @override
  Stream<String?> get outputErrorPassword => outputIsPassword
      .map((isPassword) => isPassword ? null : AppStrings.passwordInvalid);

  @override
  Stream<File> get outputIsProfile =>
      _profileStreamController.stream.map((profile) => profile);

  @override
  Stream<bool> get outputIsShowHidePassword =>
      _showHidePasswordStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputIsUserName => _userNameStreamController.stream
      .map((userName) => _isValidUserName(userName));
  @override
  Stream<String?> get outputErrorUserName => outputIsUserName
      .map((isUserName) => isUserName ? null : AppStrings.userNameInvalid);

  ///inputs methods
  @override
  Future<void> register() async {
    inputState.add(
        const LoadingState(stateRenderType: StateRenderType.popupLoadingState));

    final result = await _registerUseCase(RegisterInput(
        userName: registerObject.userName,
        countryMobileCode: registerObject.countryMobileCode,
        mobileNumber: registerObject.mobileNumber,
        email: registerObject.email,
        password: registerObject.password,
        profile: registerObject.profile));

    result.fold((failure) {
      inputState.add(ErrorState(
          stateRenderType: StateRenderType.popupErrorState,
          message: failure.message));
    }, (data) {
      inputState.add(SuccessState(
          stateRenderType: StateRenderType.popupErrorState,
          message: "welcome ${data.customer?.name ?? ""}"));
    });
  }

  @override
  void setCountryMobileCode(String code) {
    if (!_isValidMobileCode(code)) {
      registerObject = registerObject.copyWith(countryMobileCode: '');
      _validateAllInputsSink();
      return;
    }
    inputCountryMobileCode.add(code);
    registerObject = registerObject.copyWith(countryMobileCode: code);
    _validateAllInputsSink();
  }

  @override
  void setEmail(String email) {
    if (!_isValidEmail(email)) {
      registerObject = registerObject.copyWith(email: '');
      _validateAllInputsSink();
      return;
    }
    inputEmail.add(email);
    registerObject = registerObject.copyWith(email: email);
    _validateAllInputsSink();
  }

  @override
  void setMobileNumber(String mobileNumber) {
    if (!_isValidMobileNumber(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: '');
      _validateAllInputsSink();
      return;
    }
    inputMobileNumber.add(mobileNumber);
    registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    _validateAllInputsSink();
  }

  @override
  void setPassword(String password) {
    if (!_isValidPassword(password)) {
      registerObject = registerObject.copyWith(password: '');
      _validateAllInputsSink();
      return;
    }
    inputPassword.add(password);
    registerObject = registerObject.copyWith(password: password);
    _validateAllInputsSink();
  }

  @override
  void setProfile(File profile) {
    if (profile.path.isEmpty) {
      registerObject = registerObject.copyWith(profile: '');
      _validateAllInputsSink();
      return;
    }
    inputProfile.add(profile);
    registerObject = registerObject.copyWith(profile: profile.path);
    _validateAllInputsSink();
  }

  @override
  void setUserName(String userName) {
    if (!_isValidUserName(userName)) {
      registerObject = registerObject.copyWith(userName: '');
      _validateAllInputsSink();
      return;
    }
    inputUserName.add(userName);
    registerObject = registerObject.copyWith(userName: userName);
    _validateAllInputsSink();
  }

  bool show = false;
  @override
  void showHidePassword() {
    inputShowHidePassword.add(show);
    show = !show;
  }

  ///private methods
  void _validateAllInputsSink() {
    inputAreAllInputsValid.add(null);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  bool _isValidUserName(String userName) {
    return userName.length >= 5;
  }

  bool _isValidEmail(String email) {
    return isEmailValid(email);
  }

  bool _isValidMobileCode(String code) {
    return code.isNotEmpty;
  }

  bool _isValidMobileNumber(String mobileNumber) {
    return mobileNumber.length >= 9;
  }

  bool _areAllInputsValid() {
    return _isValidUserName(registerObject.userName) &&
        _isValidPassword(registerObject.password) &&
        _isValidMobileNumber(registerObject.mobileNumber) &&
        _isValidMobileCode(registerObject.countryMobileCode) &&
        _isValidEmail(registerObject.email) &&
        _isValidMobileCode(registerObject.countryMobileCode);
  }
}

abstract class RegisterInputs {
  void setUserName(String userName);
  void setCountryMobileCode(String code);
  void setMobileNumber(String mobileNumber);
  void setEmail(String email);
  void setPassword(String password);
  void setProfile(File profile);
  void showHidePassword();
  Future<void> register();

  Sink get inputUserName;
  Sink get inputCountryMobileCode;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputProfile;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
  Sink get inputShowHidePassword;
}

abstract class RegisterOutputs {
  Stream<bool> get outputIsUserName;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumber;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmail;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPassword;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsCountryMobileCode;
  Stream<File> get outputIsProfile;
  Stream<bool> get outputAreAllInputsValid;
  Stream<bool> get outputIsShowHidePassword;
}
