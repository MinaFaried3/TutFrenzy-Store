import 'dart:async';

import 'package:frenzy_store/presentation/base/base_view_model.dart';

import '../../../domain/models/onboarding_models.dart';
import '../../resources/assets_manger.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  ///base view model
  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  ///OnBoarding ViewModel Inputs
  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  ///OnBoarding ViewModel Outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  /// OnBoarding private functions
  List<SliderObject> _getSliderData() => [
        const SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        const SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        const SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        const SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        sliderObject: _list[_currentIndex],
        currentIndex: _currentIndex,
        numOfSlides: _list.length));
  }
}

abstract class OnBoardingViewModelInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
