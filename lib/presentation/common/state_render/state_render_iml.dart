import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
  final String getMessage;
  final StateRenderType getStateRenderType;

  const LoadingState(
      {this.getMessage = AppStrings.loading, required this.getStateRenderType});

  @override
  String get message => getMessage;

  @override
  StateRenderType get stateRenderType => getStateRenderType;

  @override
  List<Object> get props => [getMessage, getStateRenderType];
}

//error state popup,fullscreen

class ErrorState extends FlowState {
  final String getMessage;
  final StateRenderType getStateRenderType;

  const ErrorState(
      {this.getMessage = AppStrings.loading, required this.getStateRenderType});

  @override
  String get message => getMessage;

  @override
  StateRenderType get stateRenderType => getStateRenderType;

  @override
  List<Object> get props => [getMessage, getStateRenderType];
}

// empty only full screen

class EmptyState extends FlowState {
  final String getMessage;

  const EmptyState({required this.getMessage});

  @override
  String get message => getMessage;

  @override
  StateRenderType get stateRenderType => StateRenderType.fullScreenEmptyState;

  @override
  List<Object> get props => [getMessage];
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
  Widget getScreenWidget(
    BuildContext context,
    Widget contentWidget,
    Function retryAction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        break;
      case ErrorState:
        break;
      case EmptyState:
        break;
      case ContentState:
        break;
    }
  }
}
