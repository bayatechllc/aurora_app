import 'dart:async';

import 'package:aurora_app/core/extensions.dart';
import 'package:aurora_app/core/load_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/async.dart';

class ImagePreviewController extends GetxController {
  final LoadImageUsecase _loadImageUsecase;
  final imageRequest = Rx<Async<AuroraImage>>(Uninitialized());
  final image = Rx<AuroraImage>(AuroraImage.create());

  ImagePreviewController(this._loadImageUsecase);

  @override
  void onInit() {
    loadImage();
    super.onInit();
  }

  Future<void> loadImage() async {
    final brightness = Get.context?.theme.brightness ?? Brightness.light;
    await _loadImageUsecase.loadImageWithScheme(brightness: brightness).execute(
      (result) {
        image.value = result.call() ?? image.value;
        imageRequest.value = result;
      },
    );
  }

  Future<void> _reloadCurrentImage(Brightness brightness) async {
    final url = image.value.url;
    if (url.isEmpty) return;

    await _loadImageUsecase
        .loadImageWithScheme(url: url, brightness: brightness)
        .execute((result) {
          image.value = result.call() ?? image.value;
          imageRequest.value = result;
        });
  }

  void toggleTheme() {
    final isDark = Get.context?.theme.brightness == Brightness.dark;
    final newBrightness = isDark ? Brightness.light : Brightness.dark;
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
    _reloadCurrentImage(newBrightness);
  }
}
