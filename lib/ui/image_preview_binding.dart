import 'package:aurora_app/core/load_image_usecase.dart';
import 'package:aurora_app/data/images_repository.dart';
import 'package:get/get.dart';

import 'image_preview_controller.dart';

class ImagePreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ImagePreviewController(LoadImageUsecase(Get.find<ImagesRepository>())),
    );
  }
}
