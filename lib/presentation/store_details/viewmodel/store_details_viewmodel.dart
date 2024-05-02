import 'dart:ffi';
import 'package:advanced_flutter/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/model/models.dart';
import '../../../domain/usecase/store_details_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

// inputs

  @override
  void start() {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeDetailsUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
              // print(failure.message)
            }, (storeDetails) async {
      // right -> data (success)
      // print(data.customer?.name)

      // content
      inputState.add(ContentState());
      inputStoreDetails.add(storeDetails);
      // navigate to main screen
    });
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

// output

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract mixin class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract mixin class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
