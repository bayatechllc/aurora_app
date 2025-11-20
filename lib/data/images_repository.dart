import 'package:aurora_app/data/aurora_client.dart';

import 'model/image/image.dart';

class ImagesRepository {
  final AuroraClient _client;

  const ImagesRepository(this._client);

  Future<Image> retrieveRandomImage() async {
    final response = await _client.imagesService().retrieveRandomImage();

    if (response.isSuccessful) {
      return Image.fromJson(response.body);
    }

    throw Exception(response.error.toString());
  }
}
