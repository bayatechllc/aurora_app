import 'package:chopper/chopper.dart';

part 'images_service.chopper.dart';

@ChopperApi(baseUrl: "/image")
abstract class ImagesService extends ChopperService {
  @GET(path: "/")
  Future<Response> retrieveRandomImage();

  static ImagesService create([ChopperClient? client]) {
    return _$ImagesService(client);
  }
}
