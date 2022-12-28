import 'dart:async';
import 'dart:ffi';

import 'package:frenzy_store/domain/models/store_details_model.dart';
import 'package:frenzy_store/domain/usecase/get_store_details_use_case.dart';
import 'package:frenzy_store/presentation/base/base_view_model.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/state_render/state_render.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final GetStoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(const LoadingState(
        stateRenderType: StateRenderType.fullScreenLoadingState));
    final result = await storeDetailsUseCase(Void);

    result.fold(
      (failure) {
        inputState.add(ErrorState(
            stateRenderType: StateRenderType.fullScreenErrorState,
            message: failure.message));
      },
      (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
