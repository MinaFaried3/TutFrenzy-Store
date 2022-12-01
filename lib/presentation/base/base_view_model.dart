import 'dart:async';

import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inoutStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    _inoutStateStreamController.close();
  }

  @override
  Sink get inputState => _inoutStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inoutStateStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
