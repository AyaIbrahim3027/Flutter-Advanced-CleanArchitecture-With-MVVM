import 'package:advanced_flutter/app/dependancy_injection.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget();
            }),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(title: AppStrings.services),
        _getServices(),
        _getSection(title: AppStrings.stores),
        _getStores(),
      ],
    );
  }

  Widget _getBannersCarousel() {
    return const Center();
  }

  Widget _getSection({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getServices() {
    return const Center();
  }

  Widget _getStores() {
    return const Center();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
