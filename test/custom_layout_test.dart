import 'package:flutter/material.dart';
import 'package:flutter_swiper/src/swiper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('CustomLayoutOption', () {
    group('constructor', () {
      group('when startIndex or stateCount is null', () {
        test('it throws an assertion error', () {
          expect(() =>
            CustomLayoutOption(),
            throwsA(isA<AssertionError>())
          );
        });
      });
    });

    group('addOpacity', () {
      test('adds new value on builders list', () {
        final listOpacity = [0.0, 0.1];
        final customLayoutOptions = CustomLayoutOption(stateCount: 1, startIndex: 1);
        expect(customLayoutOptions.builders, isEmpty);

        customLayoutOptions.addOpacity(listOpacity);
        final expected = [OpacityTransformBuilder(values: listOpacity)];

        expect(customLayoutOptions.builders, equals(expected));
      });
    });

    group('addTranslate', () {
      test('adds new value on builders list', () {
        final listTransform = [Offset(0.0, 0.0)];
        final customLayoutOptions = CustomLayoutOption(stateCount: 1, startIndex: 1);
        expect(customLayoutOptions.builders, isEmpty);

        customLayoutOptions.addTranslate(listTransform);
        final expected = [TranslateTransformBuilder(values: listTransform)];
        expect(customLayoutOptions.builders, equals(expected));
      });
    });

    group('addScale', () {
      test('adds new value on builders list', () {
        final listScale = [0.0, 0.1];
        final alignment = Alignment.center;
        final customLayoutOptions = CustomLayoutOption(stateCount: 1, startIndex: 1);
        expect(customLayoutOptions.builders, isEmpty);

        customLayoutOptions.addScale(listScale, alignment);
        final expected = [ScaleTransformBuilder(values: listScale, alignment: alignment)];
        expect(customLayoutOptions.builders, equals(expected));
      });
    });

    group('addRotate', () {
      test('adds new value on builders list', () {
        final listRotate = [0.0, 0.1];
        final customLayoutOptions = CustomLayoutOption(stateCount: 1, startIndex: 1);
        expect(customLayoutOptions.builders, isEmpty);

        customLayoutOptions.addRotate(listRotate);
        final expected = [RotateTransformBuilder(values: listRotate)];
        expect(customLayoutOptions.builders, equals(expected));
      });
    });
  });
}