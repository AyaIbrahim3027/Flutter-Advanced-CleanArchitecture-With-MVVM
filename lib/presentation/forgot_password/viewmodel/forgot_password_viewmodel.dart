import 'dart:async';
import 'package:advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import '../../../app/functions.dart';
import '../../base/base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = '';

  // inputs
  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgotPasswordUseCase.execute(email)).fold(
        (failure) => {
              inputState.add(ErrorState(
                  StateRendererType.popupErrorState, failure.message))
            },
        (supportMessage) {
          inputState.add(ContentState());
        });
  }

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((isAllInputsValid) => _isAllInputsValid());

  _isAllInputsValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputsValid.add(null);
  }
}

abstract mixin class ForgotPasswordViewModelInputs {
  setEmail(String userName);
  forgotPassword();

  Sink get inputEmail;

  Sink get inputIsAllInputsValid;
}

abstract mixin class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outAreAllInputsValid;
}
