import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sum_plugin_platform_interface.dart';

/// An implementation of [SumPluginPlatform] that uses method channels.
class MethodChannelSumPlugin extends SumPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sum_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
