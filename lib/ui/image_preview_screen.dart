import 'package:aurora_app/data/model/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_preview_controller.dart';

class ImagePreviewScreen extends GetView<ImagePreviewController> {
  const ImagePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final request = controller.imageRequest.value;
      final dimen = MediaQuery.of(context).size.width;

      final theme = Theme.of(
        context,
      ).copyWith(colorScheme: controller.image.value.colorScheme);

      return Theme(
        data: theme,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("AuroraO"),
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            actions: [
              IconButton(
                onPressed: controller.toggleTheme,
                icon: Icon(Icons.color_lens_outlined),
              ),
            ],
          ),
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 2300),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(color: theme.colorScheme.surface),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Semantics(
                    container: true,
                    label: "Image preview area",
                    hint: "Loads a new image when you tap the button below",
                    child: Container(
                      width: dimen,
                      height: dimen,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainer,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        child: switch (request) {
                          Loading() => const CircularProgressIndicator(
                            semanticsLabel: "Image is loading",
                          ),

                          Fail() => _errorWidget(),

                          Uninitialized() => Text(
                            "Tap Another to load image",
                            semanticsLabel: "No image loaded yet",
                          ),

                          Success(:final data) => Semantics(
                            image: true,
                            label: "Loaded image",
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                key: ValueKey(data.url),
                                width: dimen,
                                height: dimen,
                                imageUrl: data.url,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => _errorWidget(),
                              ),
                            ),
                          ),
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Semantics(
                    button: true,
                    enabled: request is! Loading,
                    label: "Load another image",
                    hint: request is Loading
                        ? "Loading in progress, button disabled"
                        : "Double tap to load a new random image",
                    child: FilledButton(
                      onPressed: request is Loading
                          ? null
                          : controller.loadImage,
                      child: const Text("Another"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _errorWidget() => Semantics(
    label: "Failed to load image",
    hint: "Try again by tapping the Another button",
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        const Icon(Icons.broken_image),
        const SizedBox(width: 10),
        const Text("Failed to load"),
      ],
    ),
  );
}
