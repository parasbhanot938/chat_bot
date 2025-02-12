import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sum_plugin_method_channel.dart';

abstract class SumPluginPlatform extends PlatformInterface {
  /// Constructs a SumPluginPlatform.
  SumPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SumPluginPlatform _instance = MethodChannelSumPlugin();

  /// The default instance of [SumPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSumPlugin].
  static SumPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SumPluginPlatform] when
  /// they register themselves.
  static set instance(SumPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
