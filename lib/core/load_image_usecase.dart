import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/images_repository.dart';
import '../data/model/async.dart';
import 'extensions.dart';

class AuroraImage {
  final ColorScheme? colorScheme;

  final String url;

  AuroraImage(this.url, {this.colorScheme});

  static AuroraImage create() => AuroraImage("");
}

class LoadImageUsecase {
  final ImagesRepository repo;

  LoadImageUsecase(this.repo);

  /// Loads an image (random or existing) and extracts a `ColorScheme` using the
  /// provided [brightness].
  ///
  /// Behavior:
  /// - If [url] is provided:
  ///       → Reloads the SAME image and regenerates its `ColorScheme` based on
  ///         the new brightness.
  /// - If [url] is null:
  ///       → Retrieves a new random image, then extracts its `ColorScheme`.
  ///
  /// Internal steps:
  ///   1. Determine the image URL (either provided or fetched randomly)
  ///   2. Resolve the image provider and wait until the image is fully decoded
  ///   3. Generate a `ColorScheme` using `ColorScheme.fromImageProvider`
  ///   4. Return an `AuroraImage` containing both URL and dynamically generated scheme
  ///
  /// Notes:
  /// - Brightness must be passed explicitly to avoid asynchronous UI-latency issues
  ///   that occur when reading `context.theme.brightness` after `changeThemeMode`.
  Future<Async<AuroraImage>> loadImageWithScheme({
    String? url,
    required Brightness brightness,
  }) async {
    return safe(() async {
      // 1. Determine image source
      final actualUrl = url ?? (await repo.retrieveRandomImage()).url;

      // 2. Prepare provider
      final provider = CachedNetworkImageProvider(actualUrl);

      // 3. Ensure provider resolves
      await _wait(provider);

      // 4. Generate color scheme from image
      final scheme = await ColorScheme.fromImageProvider(
        brightness: brightness,
        provider: provider,
      );

      // 5. Return final decorated image
      return AuroraImage(actualUrl, colorScheme: scheme);
    });
  }

  Future<void> _wait(ImageProvider provider) {
    final completer = Completer<void>();

    provider
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener(
            (image, _) => completer.complete(),
            onError: (e, st) => completer.completeError(e),
          ),
        );

    return completer.future;
  }
}
