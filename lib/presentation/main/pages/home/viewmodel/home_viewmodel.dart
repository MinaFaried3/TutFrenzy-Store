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
  final StreamController _homeDataStreamController =
      BehaviorSubject<HomeViewObject>();

  final GetHomeUseCase _getHomeUseCase;

  HomeViewModel(this._getHomeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _homeDataStreamController.close();
  }

  ///sink inputs
  @override
  Sink get inputHomeData => _homeDataStreamController.sink;

  ///output
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _homeDataStreamController.stream.map((homeData) => homeData);

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
      printK("data is here {{{ ${data.data.banners.first.title} }}}");
      inputHomeData.add(HomeViewObject(
          data.data.stores, data.data.services, data.data.banners));
      inputState.add(ContentState());
    });
  }
}

abstract class HomeViewModeInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModeOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<Banner> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
