import 'dart:async';
import 'dart:ffi';

import 'package:advanced_flutter/domain/model/models.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/home_usecase.dart';
import '../../../../base/base_view_model.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // inputs

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void))
        .fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message))
          // print(failure.message)
        },
            (homeObject) {
          // right -> data (success)
          // print(data.customer?.name)

          // content
          inputState.add(ContentState());

          inputBanners.add(homeObject.data?.banners);
          inputServices.add(homeObject.data?.services);
          inputStores.add(homeObject.data?.stores);
              // navigate to main screen
        });
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // outputs

  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  // TODO: implement outputServices
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  // TODO: implement outputStores
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

abstract mixin class HomeViewModelInput {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract mixin class HomeViewModelOutput {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;
}
