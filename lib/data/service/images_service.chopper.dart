// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'images_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ImagesService extends ImagesService {
  _$ImagesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ImagesService;

  @override
  Future<Response<dynamic>> retrieveRandomImage() {
    final Uri $url = Uri.parse('/image/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
