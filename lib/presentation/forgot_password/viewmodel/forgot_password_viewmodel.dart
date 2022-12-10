import 'dart:async';

import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/domain/usecase/forgot_password_use_case.dart';
import 'package:frenzy_store/presentation/base/base_view_model.dart';
import 'package:frenzy_store/presentation/common/freezed_data_class.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordInputs, ForgotPasswordOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var forgotPasswordObject = ForgotPasswordObject("");
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  /// base view model
  @override
  void start() {
    //show content state
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  /// inputs
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  /// output
  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => _isValidEmail(email));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  /// inputs methods
  @override
  void setEmail(String email) {
    inputEmail.add(email);
    forgotPasswordObject = forgotPasswordObject.copyWith(email: email);
    inputAreAllInputsValid.add(null);
  }

  @override
  Future<void> forgotPassword() async {
    // 1- loading
    inputState.add(
        const LoadingState(stateRenderType: StateRenderType.popupLoadingState));

    //2- fetch the data
    final result = await _forgotPasswordUseCase(
        ForgotPasswordInput(forgotPasswordObject.email));

    result.fold((failure) {
      //show error state
      printK("failure is here {{{ ${failure.message} }}}");
      inputState.add(ErrorState(
          stateRenderType: StateRenderType.popupErrorState,
          message: failure.message));
    }, (data) {
      inputState.add(ErrorState(
          stateRenderType: StateRenderType.popupErrorState,
          message: data.supportMessage));
    });
  }

  ///view model methods
  bool _isValidEmail(String email) {
    return email.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isValidEmail(forgotPasswordObject.email);
  }
}

abstract class ForgotPasswordInputs {
  void setEmail(String email);
  Future<void> forgotPassword();

  Sink get inputEmail;
  Sink get inputAreAllInputsValid;
}

abstract class ForgotPasswordOutputs {
  Stream<bool> get outIsEmailValid;
  Stream<bool> get outputAreAllInputsValid;
}
