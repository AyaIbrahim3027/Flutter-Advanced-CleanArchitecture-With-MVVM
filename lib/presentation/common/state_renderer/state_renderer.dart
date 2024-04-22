import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/font_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

enum StateRendererType {
  // POPUP STATE (Dialog)
  popupLoadingState,
  popupErrorState,

  // FULL SCREEN STATE (Full Screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // GENERAL
  contentState,
}

class StateRenderer extends StatelessWidget {
  const StateRenderer(
      {super.key,
      required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = '',
      required this.retryActionFunction});

  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionFunction;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
      // TODO: Handle this case.
      case StateRendererType.popupErrorState:
      // TODO: Handle this case.
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage(),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain),
        ]);
      case StateRendererType.fullScreenEmptyState:
      // TODO: Handle this case.
      case StateRendererType.contentState:
      // TODO: Handle this case.
    }
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Container(), // todo add json image here
    );
  }

  Widget _getMessage(String message) {
    return Text(
      message,
      style: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(buttonTitle),
    );
  }
}
