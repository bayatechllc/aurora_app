import 'package:flutter/material.dart';

import '../data/model/async.dart';

extension FutureExtensions<T> on Future<Async<T>> {
  Future<void> execute(Function(Async<T> result) callback) async {
    callback(Loading());

    try {
      final response = await this;

      if (response is Fail<T>) {
        debugPrint("API Error: ${response.message}");
        // Todo: Error logging for analytics
      }

      callback(response);
    } catch (e, stackTrace) {
      // Todo: Error logging for analytics
      debugPrint('Error occurred: $e');
      debugPrint('Stack trace: $stackTrace');
      callback(Fail("An unexpected error occurred. Please try again."));
    }
  }
}

Future<Async<T>> safe<T>(Future<T> Function() task) async {
  try {
    final data = await task();
    return Success(data);
  } catch (e) {
    debugPrint("Service Error: $e");
    return Fail(e.toString());
  }
}
