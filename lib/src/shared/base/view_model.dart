import 'dart:async';

import 'package:file_share_app/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewModel extends GetxController {
  final _isShowLoading = false.obs;
  bool get isShowLoading => _isShowLoading.value;

  void setShowLoading(bool value) {
    _isShowLoading.value = value;
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void runAction<T>(
    Future Function() action, {
    bool showLoading = false,
    bool showError = false,
    void Function()? beforeAction,
    FutureOr Function(T)? onSuccess,
    FutureOr Function(AppError error)? onError,
  }) async {
    if (beforeAction != null) {
      beforeAction();
    }
    if (showLoading) {
      setShowLoading(true);
    }
    try {
      final result = await action();
      if (onSuccess != null) {
        setShowLoading(false);
        onSuccess(result);
      }
    } catch (e) {
      if (showError) {
        Get.closeAllSnackbars();
        Get.snackbar('Error', e.toString());
      }
      if (onError != null) {
        if (e is AppError) {
          onError(e);
        } else {
          onError(AppError(e.toString()));
        }
      }
    } finally {
      if (showLoading) {
        setShowLoading(false);
      }
    }
  }

  void showError({
    required String? title,
    required String message,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title ?? 'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void showSuccess({
    required String? title,
    required String message,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title ?? 'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
