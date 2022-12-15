import 'dart:async';
import 'dart:ffi';

import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/domain/models/home_model.dart';
import 'package:frenzy_store/domain/usecase/get_home_data_use_case.dart';
import 'package:frenzy_store/presentation/base/base_view_model.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModeInputs, HomeViewModeOutputs {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<Banner>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  final GetHomeUseCase _getHomeUseCase;

  HomeViewModel(this._getHomeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
  }

  ///sink inputs
  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  ///output
  @override
  Stream<List<Banner>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);

  ///private methods
  Future<void> _getHomeData() async {
    inputState.add(const LoadingState(
        stateRenderType: StateRenderType.fullScreenLoadingState));
    final result = await _getHomeUseCase(Void);
    //3- final result
    result.fold((failure) {
      //show error state
      printK("failure is here {{{ ${failure.message} }}}");
      inputState.add(ErrorState(
          stateRenderType: StateRenderType.fullScreenErrorState,
          message: failure.message));
    }, (data) {
      printK("data is here {{{ ${data.data?.banners.first.title} }}}");
      inputState.add(ContentState());
      inputBanners.add(data.data?.banners);
      inputServices.add(data.data?.services);
      inputStores.add(data.data?.stores);
    });
  }
}

abstract class HomeViewModeInputs {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModeOutputs {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<Banner>> get outputBanners;
}
