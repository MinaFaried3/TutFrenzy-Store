import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
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
    super.dispose();
    _streamController.close();
  }

  ///base view model
  @override
  void start() {
    _list = _getSliderData();
    //init object
    _postDataToView();
  }

  @override
  int goNext() {
    _currentIndex++;

    if (_currentIndex == _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  ///OnBoarding ViewModel Inputs
  @override
  int goPrevious() {
    _currentIndex--;

    if (_currentIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
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
        SliderObject(AppStrings.onBoardingTitle1.tr(),
            AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2.tr(),
            AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3.tr(),
            AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4.tr(),
            AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onBoardingLogo4),
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
