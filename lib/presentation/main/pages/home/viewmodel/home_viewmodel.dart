import 'dart:async';

import 'package:advanced_flutter/domain/model/models.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/home_usecase.dart';
import '../../../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  final HomeUseCase homeUseCase;

  HomeViewModel(this.homeUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }
}
