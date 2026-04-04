import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useSplashTransition(
  VoidCallback onCompleted, {
  Duration delay = const Duration(seconds: 2),
}) {
  useEffect(
    () {
      final timer = Timer(delay, onCompleted);
      return timer.cancel;
    },
    [delay, onCompleted],
  );
}
