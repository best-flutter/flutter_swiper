import 'package:flutter/material.dart';
import 'package:flutter_swiper/src/swiper_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSwiperPlugin extends Mock implements SwiperPlugin {}
class MockSwiperPluginConfig extends Mock implements SwiperPluginConfig {}
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('SwiperPluginConfig', () {
    group('constructor', () {
      group('when scrollDirection is null', () {
        test('it throws an assertion error', () {
          expect(() =>
            SwiperPluginConfig(scrollDirection: null),
            throwsA(isA<AssertionError>())
          );
        });
      });

      group('when controller is null', () {
        test('it throws an assertion error', () {
          expect(() =>
            SwiperPluginConfig(scrollDirection: Axis.horizontal),
            throwsA(isA<AssertionError>())
          );
        });
      });
    });
  });

  group('SwiperPluginView', () {
    group('constructor', () {
      group('when plugin is null', () {
        test('it throws an assertion error', () {
          expect(() =>
            SwiperPluginView(null, null),
            throwsA(isA<AssertionError>())
          );
        });
      });
    });

    group('build', () {
      MockSwiperPlugin mockSwiperPlugin;
      MockSwiperPluginConfig mockSwiperPluginConfig;
      MockBuildContext mockBuildContext;
      SwiperPluginView swiperPluginView;

      setUp(() {
        mockSwiperPlugin = MockSwiperPlugin();
        mockSwiperPluginConfig = MockSwiperPluginConfig();
        mockBuildContext = MockBuildContext();
        swiperPluginView = SwiperPluginView(mockSwiperPlugin, mockSwiperPluginConfig);
      });

      test('it calls plugin build method passing the config args', () {
        swiperPluginView.build(mockBuildContext);

        verify(mockSwiperPlugin.build(mockBuildContext, mockSwiperPluginConfig));
      });
    });
  });
}