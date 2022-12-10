import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';

abstract class FlowState extends Equatable {
  String get message;

  StateRenderType get stateRenderType;

  const FlowState();
}

// loading state popup,fullscreen
class LoadingState extends FlowState {
  final String _message;
  final StateRenderType _stateRenderType;

  const LoadingState(
      {String message = AppStrings.loading,
      required StateRenderType stateRenderType})
      : _message = message,
        _stateRenderType = stateRenderType;

  @override
  String get message => _message;

  @override
  StateRenderType get stateRenderType => _stateRenderType;

  @override
  List<Object> get props => [_message, _stateRenderType];
}

//error state popup,fullscreen
class ErrorState extends FlowState {
  final String _message;
  final StateRenderType _stateRenderType;

  const ErrorState(
      {String message = AppStrings.loading,
      required StateRenderType stateRenderType})
      : _message = message,
        _stateRenderType = stateRenderType;

  @override
  String get message => _message;

  @override
  StateRenderType get stateRenderType => _stateRenderType;

  @override
  List<Object> get props => [_message, _stateRenderType];
}

// success state
class SuccessState extends FlowState {
  final String _message;
  final StateRenderType _stateRenderType;

  const SuccessState(
      {String message = AppStrings.loading,
      required StateRenderType stateRenderType})
      : _message = message,
        _stateRenderType = stateRenderType;

  @override
  String get message => _message;

  @override
  StateRenderType get stateRenderType => _stateRenderType;

  @override
  List<Object> get props => [_message, _stateRenderType];
}

// empty only full screen

class EmptyState extends FlowState {
  final String _message;

  const EmptyState({required String message}) : _message = message;

  @override
  String get message => _message;

  @override
  StateRenderType get stateRenderType => StateRenderType.fullScreenEmptyState;

  @override
  List<Object> get props => [_message];
}

// content state

class ContentState extends FlowState {
  @override
  String get message => Constants.empty;

  @override
  StateRenderType get stateRenderType => StateRenderType.contentState;

  @override
  List<Object> get props => [];
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget({
    required BuildContext context,
    required Widget contentWidget,
    required Function retryAction,
  }) {
    switch (runtimeType) {
      case LoadingState:
        if (stateRenderType == StateRenderType.popupLoadingState) {
          // popup
          showPopup(context, stateRenderType, message);
          // behind popup
          return contentWidget;
        } else {
          return StateRenderer(
              stateRenderType: stateRenderType,
              message: message,
              retryAction: retryAction);
        }
      case ErrorState:
        _dismissDialog(context);
        if (stateRenderType == StateRenderType.popupErrorState) {
          // popup
          showPopup(context, stateRenderType, message);
          // behind popup
          return contentWidget;
        } else {
          return StateRenderer(
              stateRenderType: stateRenderType,
              message: message,
              retryAction: retryAction);
        }
      case SuccessState:
        _dismissDialog(context);
        // popup
        showPopup(context, stateRenderType, message);
        // behind popup
        return contentWidget;

      case EmptyState:
        return StateRenderer(
            stateRenderType: stateRenderType,
            message: message,
            retryAction: () {});
      case ContentState:
        _dismissDialog(context);
        return contentWidget;
      default:
        _dismissDialog(context);
        return contentWidget;
    }
  }

  bool _isCurrentDialogShowing(BuildContext context) =>
      (ModalRoute.of(context)!.isCurrent) == false;

  void _dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  void showPopup(
    BuildContext context,
    StateRenderType stateRenderType,
    String message,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
            stateRenderType: stateRenderType,
            message: message,
            retryAction: () {},
          ),
        ));
  }
}
