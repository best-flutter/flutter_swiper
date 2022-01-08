// ignore_for_file: cascade_invocations

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Default Swiper', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Swiper(
          itemBuilder: (context, index) {
            return const Text('0');
          },
          itemCount: 10,
        ),
      ),
    );

    expect(find.text('0', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Default Swiper loop:false', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: Swiper(
      onTap: (index) {},
      itemBuilder: (context, index) {
        return const Text('0');
      },
      itemCount: 10,
      loop: false,
    )));

    expect(find.text('0', skipOffstage: true), findsOneWidget);
  });

  testWidgets('Create Swiper with children', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: Swiper.children(
      children: const <Widget>[
        Text('0'),
        Text('1'),
      ],
    )));

    expect(find.text('0', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Create Swiper with list', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Swiper.list<String>(
        list: ['0', '1'],
        builder: (context, data, index) {
          return Text(data);
        },
      ),
    ));

    expect(find.text('0', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Swiper with default plugins', (tester) async {
    // Build our app and trigger a frame.
    final controller = SwiperController();
    await tester.pumpWidget(MaterialApp(
      home: Swiper(
        controller: controller,
        itemBuilder: (context, index) {
          return const Text('0');
        },
        itemCount: 10,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    ));

    expect(find.text('0', skipOffstage: false), findsOneWidget);
  });

  const titles = <String>['Flutter Swiper is awesome', 'Really nice', 'Yeah'];

  testWidgets('Customize pagination', (tester) async {
    // Build our app and trigger a frame.
    final controller = SwiperController();
    await tester.pumpWidget(
      MaterialApp(
        home: Swiper(
          controller: controller,
          itemBuilder: (context, index) {
            return const Text('0');
          },
          itemCount: 10,
          pagination: SwiperCustomPagination(
            builder: (context, config) {
              return ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 50.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: const DotSwiperPaginationBuilder(
                          color: Colors.black12,
                          activeColor: Colors.black,
                          size: 10.0,
                          activeSize: 20.0,
                        ).build(context, config),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          control: const SwiperControl(),
        ),
      ),
    );

    controller.startAutoplay();

    controller.stopAutoplay();

    await controller.move(0, animation: false);
    await controller.move(0, animation: false);

    await controller.next(animation: false);
    await controller.previous(animation: false);

    expect(find.text('0', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Swiper fraction', (tester) async {
    // Build our app and trigger a frame.
    final controller = SwiperController();
    await tester.pumpWidget(MaterialApp(
      home: Swiper(
        controller: controller,
        itemBuilder: (context, index) {
          return const Text('0');
        },
        itemCount: 10,
        pagination: const SwiperPagination(builder: SwiperPagination.fraction),
        control: const SwiperControl(),
      ),
    ));

    expect(find.text('0', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Zero itemCount', (tester) async {
    // Build our app and trigger a frame.
    final controller = SwiperController();
    await tester.pumpWidget(MaterialApp(
        home: Swiper(
      controller: controller,
      itemBuilder: (context, index) {
        return const Text('0');
      },
      itemCount: 0,
      pagination: const SwiperPagination(builder: SwiperPagination.fraction),
      control: const SwiperControl(),
    )));

    expect(find.text('0', skipOffstage: false), findsNothing);
  });
}
