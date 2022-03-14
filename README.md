![Logo](banner.jpg)

<p align="center">
    <a href="https://github.com/TheAnkurPanchani/flutter_swiper/pulls">
        <img src="https://img.shields.io/badge/PRs-Welcome-brightgreen.svg" alt="PRs Welcome" />
    </a>
    <a href="https://pub.dev/packages/card_swiper">
        <img src="https://img.shields.io/pub/v/card_swiper.svg" alt="pub package" />
    </a>
</p>

# card_swiper

Swiper/Carousel for flutter, with multiple layouts, infinite loop. Compatible with Android & iOS.

# :sparkles::sparkles: New Features:Layout for pagination.

We are using this project [flutter_page_indicator](https://github.com/best-flutter/flutter_page_indicator) now .

# :sparkles::sparkles: New Features:PageTransformer

Finally, we have `PageTransformer` like android, just set a `transformer` to `Swiper`,
it returns a widget that has been transformed. For now, only support for layout `DEFAULT`.
Thanks to @FlutterRocks ,you've done great job 👏.

We are using this project [transformer_page_view](https://github.com/best-flutter/transformer_page_view) now .

# :sparkles::sparkles: New Features:Layout

![](https://github.com/jzoom/images/raw/master/layout1.gif)

![](https://github.com/jzoom/images/raw/master/layout2.gif)

![](https://github.com/jzoom/images/raw/master/layout3.gif)

[See More](#build-in-layouts)

# Showcases

![Horizontal](https://github.com/jzoom/flutter_swiper/raw/master/example/res/1.gif)

![Vertical](https://github.com/jzoom/flutter_swiper/raw/master/example/res/2.gif)

![Custom Pagination](https://github.com/jzoom/flutter_swiper/raw/master/example/res/3.gif)

![Custom Pagination](https://github.com/jzoom/flutter_swiper/raw/master/example/res/4.gif)

![Phone](https://github.com/jzoom/flutter_swiper/raw/master/example/res/5.gif)

![Example](https://github.com/jzoom/images/raw/master/swiper-example.gif)

[See More](#codes)

## Changelogs

> see:[CHANGELOG.md](https://github.com/TheAnkurPanchani/flutter_swiper/blob/master/CHANGELOG.md)

## Getting Started

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Constructor](#constructor)
  - [Basic](#basic)
  - [Pagination](#pagination)
  - [Control buttons](#control-buttons)
  - [Controller](#controller)
  - [Autoplay](#autoplay)
- [Build in layouts](#build-in-layouts)
- [Codes](#codes)

### Installation

Add

```bash
card_swiper : ^2.0.1
```

to your `pubspec.yaml`, and run

```bash
flutter packages get
```

in your project's root directory.

OR

run

```bash
flutter pub add card_swiper
```

in your project's root directory.

### Basic Usage

Create a new project with command

```
flutter create myapp
```

Edit lib/main.dart like this:

```dart

import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    body: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }
}

```

### Constructor

#### Basic

| Parameter       |            Default             | Description                                                                                                                                                              |
| :-------------- | :----------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| scrollDirection |        Axis.horizontal         | If `Axis.horizontal`, the scroll view's children are arranged horizontally in a row instead of vertically in a column.                                                   |
| axisDirection   |       AxisDirection.left       | If `AxisDirection.right`, the scroll view's children are arranged right side in a row instead of left.<br>**Note:** Currently supported for horizontal stack layout only |
| loop            |              true              | Set to `false` to disable continuous loop mode.                                                                                                                          |
| index           |               0                | Index number of initial slide.                                                                                                                                           |
| autoplay        |             false              | Set to `true` enable auto play mode.                                                                                                                                     |
| onIndexChanged  | void onIndexChanged(int index) | Called with the new index when the user swiped or autoplay                                                                                                               |
| onTap           |     void onTap(int index)      | Called when user tap ui.                                                                                                                                                 |
| duration        |             300.0              | The milliscends of every transaction animation costs                                                                                                                     |
| pagination      |              null              | set `SwiperPagination()` to show default pagination                                                                                                                      |
| control         |              null              | set `SwiperControl()` to show default control buttons                                                                                                                    |

#### Pagination

The pagination extends from `SwiperPlugin`,the `SwiperPlugin` provides extra ui for `Swiper`.Set `SwiperPagination()` to show default pagination.

| Parameter |          Default           | Description                                                                                                                               |
| :-------- | :------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------- |
| alignment |   Alignment.bottomCenter   | Change this value if you what to put pagination in other place                                                                            |
| margin    | const EdgeInsets.all(10.0) | The distance between inner side of the parent container.                                                                                  |
| builder   |   SwiperPagination.dots    | There are three default styles `SwiperPagination.dots`, `SwiperPagination.fraction` and `SwiperPagination.rect`, these can be customized. |

If you'd like to customize your own pagination, you can do like this:

```dart
Swiper(
    ...,
    pagination: SwiperCustomPagination(
        builder:(BuildContext context, SwiperPluginConfig config){
            return YourOwnPagination();
        }
    )
);

```

##### Implemented pagination

###### DotSwiperPaginationBuilder

| Parameter   | Default                                   | Description              | Required |
| :---------- | :---------------------------------------- | :----------------------- | :------: |
| activeColor | Theme.of(context).primaryColor            | Active bullet color      |  false   |
| color       | Theme.of(context).scaffoldBackgroundColor | Bullet color             |  false   |
| activeSize  | 10.0                                      | Active bullet size       |  false   |
| size        | 10.0                                      | Bullet size              |  false   |
| space       | 3.0                                       | Distance between bullets |  false   |
| key         | -                                         | key                      |  false   |

###### FractionPaginationBuilder

| Parameter      | Default                                   | Description       | Required |
| :------------- | :---------------------------------------- | :---------------- | :------: |
| activeColor    | Theme.of(context).primaryColor            | Active font color |  false   |
| color          | Theme.of(context).scaffoldBackgroundColor | font color        |  false   |
| activeFontSize | 35.0                                      | Active font size  |  false   |
| fontSize       | 20.0                                      | Font size         |  false   |
| key            | -                                         | key               |  false   |

###### RectSwiperPaginationBuilder

| Parameter   | Default                                   | Description              | Required |
| :---------- | :---------------------------------------- | :----------------------- | :------: |
| activeColor | Theme.of(context).primaryColor            | Active bullet color      |  false   |
| color       | Theme.of(context).scaffoldBackgroundColor | Bullet color             |  false   |
| activeSize  | 10.0                                      | Active bullet size       |  false   |
| size        | 10.0                                      | Bullet size              |  false   |
| space       | 3.0                                       | Distance between bullets |  false   |
| key         | -                                         | key                      |  false   |

#### Control buttons

The control also extends from `SwiperPlugin`,set `SwiperControl()` to show default control buttons.

| Parameter    |             Default             | Description                                        |
| :----------- | :-----------------------------: | :------------------------------------------------- |
| iconPrevious |      Icons.arrow_back_ios       | The icon data to display `previous` control button |
| iconNext     |     Icons.arrow_forward_ios     | The icon data to display `next`.                   |
| color        | Theme.of(context).primaryColor  | Control button color                               |
| disableColor | Theme.of(context).disabledColor | Disabled control button color                      |
| size         |              30.0               | Control button size                                |
| padding      |    const EdgeInsets.all(5.0)    | Control button padding                             |

#### Controller

The `Controller` is used to control the `index` of the Swiper, start or stop autoplay.You can create a controller by `SwiperController()` and save the instance by futher usage.

| Method                                       | Description                                         |
| :------------------------------------------- | :-------------------------------------------------- |
| void move(int index, {bool animation: true}) | Move to the spicified `index`,with animation or not |
| void next({bool animation: true})            | Move to next                                        |
| void previous({bool animation: true})        | Move to previous                                    |
| void startAutoplay()                         | Start autoplay                                      |
| void stopAutoplay()                          | Stop autoplay                                       |

#### Autoplay

| Parameter                    | Default | Description                                          |
| :--------------------------- | :-----: | :--------------------------------------------------- |
| autoplayDelay                |  3000   | Autoplay delay milliseconds.                         |
| autoplayDisableOnInteraction |  true   | If set true, `autoplay` is disabled when use swipes. |

## Build in layouts

![](https://github.com/jzoom/images/raw/master/layout1.gif)

```dart
Swiper(
  itemBuilder: (BuildContext context, int index) {
    return Image.network(
      "https://via.placeholder.com/288x188",
      fit: BoxFit.fill,
    );
  },
  itemCount: 10,
  viewportFraction: 0.8,
  scale: 0.9,
)

```

![](https://github.com/jzoom/images/raw/master/layout2.gif)

```dart
Swiper(
  itemBuilder: (BuildContext context, int index) {
    return Image.network(
      "https://via.placeholder.com/288x188",
      fit: BoxFit.fill,
    );
  },
  itemCount: 10,
  itemWidth: 300.0,
  layout: SwiperLayout.STACK,
)
```

![](https://github.com/jzoom/images/raw/master/layout3.gif)

```dart
Swiper(
    itemBuilder: (BuildContext context, int index) {
      return Image.network(
        "https://via.placeholder.com/288x188",
        fit: BoxFit.fill,
      );
    },
    itemCount: 10,
    itemWidth: 300.0,
    itemHeight: 400.0,
    layout: SwiperLayout.TINDER,
 )
```

![](https://github.com/jzoom/images/raw/master/layout4.gif)

Very easy to create you own custom animation:

```dart

Swiper(
  layout: SwiperLayout.CUSTOM,
  customLayoutOption: CustomLayoutOption(
    startIndex: -1,
    stateCount: 3
  )..addRotate([
    -45.0/180,
    0.0,
    45.0/180
  ])..addTranslate([
    Offset(-370.0, -40.0),
    Offset(0.0, 0.0),
    Offset(370.0, -40.0)
  ]),
  itemWidth: 300.0,
  itemHeight: 200.0,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Text("$index"),
      ),
    );
  },
  itemCount: 10,
)

```

The `CustomLayoutOption` is designed to describe animations.
It is very easy to specify every state of items in Swiper.

```dart
CustomLayoutOption(
  // Which index is the first item of array below
  startIndex: -1,
  // array length
  stateCount: 3
)..addRotate([
  // rotation of every item
  -45.0/180,
  0.0,
  45.0/180
])..addTranslate([
  // offset of every item
  Offset(-370.0, -40.0),
  Offset(0.0, 0.0),
  Offset(370.0, -40.0)
]);

```

## Codes

![Example](https://github.com/jzoom/images/raw/master/swiper-example.gif)

```dart
ConstrainedBox(
  child: Swiper(
    outer:false,
    itemBuilder: (c, i) {
      return Wrap(
        runSpacing: 6.0,
        children: [0,1,2,3,4,5,6,7,8,9].map((i){
          return SizedBox(
            width: MediaQuery.of(context).size.width/5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  child: Container(
                    child: Image.network("https://fuss10.elemecdn.com/c/db/d20d49e5029281b9b73db1c5ec6f9jpeg.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90"),
                  ),
                  height: MediaQuery.of(context).size.width * 0.12,
                  width: MediaQuery.of(context).size.width * 0.12,
                ),
                Padding(padding: EdgeInsets.only(top:6.0),child: Text("$i"),)
              ],
            ),
          );
        }).toList(),
      );
    },
    pagination: SwiperPagination(
      margin: EdgeInsets.all(5.0)
    ),
    itemCount: 10,
  ),
    constraints:BoxConstraints.loose(Size(screenWidth, 170.0))
),

```

# FAQs

## How to remove default controlls?

- Do not pass any value in `control` parameter of constructor

## How to remove default pagination?

- Do not pass any value in `pagination` parameter of constructor

---

You can find all custom options here:

> https://github.com/TheAnkurPanchani/flutter_swiper/blob/master/example/lib/src/ExampleCustom.dart
