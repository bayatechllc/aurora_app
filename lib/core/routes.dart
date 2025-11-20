import 'package:aurora_app/ui/image_preview_screen.dart';
import 'package:get/get.dart';

import '../ui/image_preview_binding.dart';

class Routes {
  static const imagePreview = "/imagePreview";

  static final pages = [
    GetPage(
      name: Routes.imagePreview,
      page: () => ImagePreviewScreen(),
      binding: ImagePreviewBinding(),
    ),
  ];
}
