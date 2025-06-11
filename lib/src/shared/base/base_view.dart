import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view_model.dart';

abstract class BaseView<Controller extends ViewModel> extends GetView<Controller> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildView(context),
        Obx(() {
          if (controller.isShowLoading) {
            return buildLoading();
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  @protected
  @required
  Widget buildView(BuildContext context);

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Controller get viewModel => controller;
}
