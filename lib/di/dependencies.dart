import 'dart:developer';

import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/aurora_client.dart';
import '../data/images_repository.dart';

class Dependencies {
  static init() {
    // Init Logger
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      log('${record.level.name}: ${record.time}: ${record.message}');
    });

    // Init Dependencies
    Get.put<AuroraClient>(AuroraClient());
    Get.put<ImagesRepository>(ImagesRepository(Get.find<AuroraClient>()));
  }
}
