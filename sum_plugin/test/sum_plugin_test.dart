import 'package:flutter_test/flutter_test.dart';
import 'package:sum_plugin/sum_plugin.dart';
import 'package:sum_plugin/sum_plugin_platform_interface.dart';
import 'package:sum_plugin/sum_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSumPluginPlatform
    with MockPlatformInterfaceMixin
    implements SumPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SumPluginPlatform initialPlatform = SumPluginPlatform.instance;

  test('$MethodChannelSumPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSumPlugin>());
  });

  test('getPlatformVersion', () async {
    SumPlugin sumPlugin = SumPlugin();
    MockSumPluginPlatform fakePlatform = MockSumPluginPlatform();
    SumPluginPlatform.instance = fakePlatform;

    expect(await sumPlugin.getPlatformVersion(), '42');
  });
}
