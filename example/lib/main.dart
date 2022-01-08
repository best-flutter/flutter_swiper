import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'src/config.dart';
import 'src/example_custom.dart';
import 'src/example_swiper_in_scrollview.dart';

void main() => runApp(const MyApp());

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'Flutter Swiper'),
      routes: {
        '/example01': (context) => const ExampleHorizontal(),
        '/example02': (context) => const ExampleVertical(),
        '/example03': (context) => const ExampleFraction(),
        '/example04': (context) => const ExampleCustomPagination(),
        '/example05': (context) => const ExamplePhone(),
        '/example06': (context) => const ScaffoldWidget(
              child: ExampleSwiperInScrollView(),
              title: 'ScrollView',
            ),
        '/example07': (context) => const ScaffoldWidget(
              child: ExampleCustom(),
              title: 'Custom All',
            )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> render(BuildContext context, List<List<String>> children) {
    return ListTile.divideTiles(
      context: context,
      tiles: children.map((data) {
        return buildListTile(context, data[0], data[1], data[2]);
      }),
    ).toList();
  }

  Widget buildListTile(
      BuildContext context, String title, String subtitle, String url) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(url);
      },
      isThreeLine: true,
      dense: false,
      leading: null,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(
        Icons.arrow_right,
        color: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // DateTime moonLanding = DateTime.parse("1969-07-20");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: render(context, [
          ['Horizontal', 'Scroll Horizontal', '/example01'],
          ['Vertical', 'Scroll Vertical', '/example02'],
          ['Fraction', 'Fraction style', '/example03'],
          ['Custom Pagination', 'Custom Pagination', '/example04'],
          ['Phone', 'Phone view', '/example05'],
          ['ScrollView ', 'In a ScrollView', '/example06'],
          ['Custom', 'Custom all properties', '/example07']
        ]),
      ),
    );
  }
}

const List<String> titles = [
  'Flutter Swiper is awesome',
  'Really nice',
  'Yeah'
];

class ExampleHorizontal extends StatelessWidget {
  const ExampleHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExampleHorizontal'),
      ),
      body: Swiper(
        itemBuilder: (context, index) {
          final image = images[index];
          return Image.asset(
            image,
            fit: BoxFit.fill,
          );
        },
        indicatorLayout: PageIndicatorLayout.COLOR,
        autoplay: true,
        itemCount: images.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}

class ExampleVertical extends StatelessWidget {
  const ExampleVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ExampleVertical'),
        ),
        body: Swiper(
          itemBuilder: (context, index) {
            return Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: images.length,
          scrollDirection: Axis.vertical,
          pagination: const SwiperPagination(alignment: Alignment.centerRight),
          control: const SwiperControl(),
        ));
  }
}

class ExampleFraction extends StatelessWidget {
  const ExampleFraction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ExampleFraction'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Swiper(
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: images.length,
              pagination:
                  const SwiperPagination(builder: SwiperPagination.fraction),
              control: const SwiperControl(),
            )),
            Expanded(
                child: Swiper(
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: images.length,
              scrollDirection: Axis.vertical,
              pagination: const SwiperPagination(
                  alignment: Alignment.centerRight,
                  builder: SwiperPagination.fraction),
            ))
          ],
        ));
  }
}

class ExampleCustomPagination extends StatelessWidget {
  const ExampleCustomPagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom Pagination'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                itemBuilder: (context, index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: SwiperPagination(
                    margin: EdgeInsets.zero,
                    builder: SwiperCustomPagination(builder: (context, config) {
                      return ConstrainedBox(
                        child: Container(
                          color: Colors.white,
                          child: Text(
                            '${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                        constraints: const BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: const SwiperControl(),
              ),
            ),
            Expanded(
              child: Swiper(
                itemBuilder: (context, index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: SwiperPagination(
                    margin: EdgeInsets.zero,
                    builder: SwiperCustomPagination(builder: (context, config) {
                      return ConstrainedBox(
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
                                        activeSize: 20.0)
                                    .build(context, config),
                              ),
                            )
                          ],
                        ),
                        constraints: const BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: const SwiperControl(color: Colors.redAccent),
              ),
            )
          ],
        ));
  }
}

class ExamplePhone extends StatelessWidget {
  const ExamplePhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone'),
      ),
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              'images/bg.jpeg',
              fit: BoxFit.fill,
            ),
          ),
          Swiper.children(
            autoplay: false,
            pagination: const SwiperPagination(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                builder: DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: Colors.white,
                    size: 20.0,
                    activeSize: 20.0)),
            children: <Widget>[
              Image.asset(
                'images/1.png',
                fit: BoxFit.contain,
              ),
              Image.asset(
                'images/2.png',
                fit: BoxFit.contain,
              ),
              Image.asset('images/3.png', fit: BoxFit.contain)
            ],
          )
        ],
      ),
    );
  }
}

class ScaffoldWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;

  const ScaffoldWidget({
    Key? key,
    required this.title,
    required this.child,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: child,
    );
  }
}
