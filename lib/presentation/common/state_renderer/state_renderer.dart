import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
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
}
