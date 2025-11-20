import 'dart:io';

import 'package:aurora_app/data/service/images_service.dart';
import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as http;

const _baseUrl = "https://november7-730026606190.europe-west1.run.app";

class AuroraClient {
  final _chopper = ChopperClient(
    baseUrl: Uri.parse(_baseUrl),
    client: http.IOClient(
      HttpClient()..connectionTimeout = const Duration(seconds: 60),
    ),
    errorConverter: const JsonConverter(),
    converter: const JsonConverter(),
    interceptors: [HttpLoggingInterceptor()],
  );

  ImagesService imagesService() => ImagesService.create(_chopper);
}
