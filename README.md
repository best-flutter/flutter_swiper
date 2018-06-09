language : [English](https://github.com/jzoom/flutter_swiper) | [中文](https://github.com/jzoom/flutter_swiper/blob/master/README-ZH.md)

[![build_status](https://travis-ci.org/jzoom/flutter_swiper.svg?branch=master)](https://travis-ci.org/jzoom/flutter_swiper)

# flutter_swiper

The best swiper for flutter.

![Horizontal](https://github.com/jzoom/flutter_swiper/raw/master/example/res/1.gif)

![Vertical](https://github.com/jzoom/flutter_swiper/raw/master/example/res/2.gif)

![Custom Pagination](https://github.com/jzoom/flutter_swiper/raw/master/example/res/3.gif)

![Custom Pagination](https://github.com/jzoom/flutter_swiper/raw/master/example/res/4.gif)

![Phone](https://github.com/jzoom/flutter_swiper/raw/master/example/res/5.gif)


## Roadmap

>see:[ROADMAP.md](https://github.com/jzoom/flutter_swiper/blob/master/ROADMAP.md)

## Changelogs

>see:[CHANGELOG.md](https://github.com/jzoom/flutter_swiper/blob/master/CHANGELOG.md)

## Getting Started

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Constructor](#constructor)
  + [Basic](#basic)
  + [Pagination](#pagination)
  + [Control buttons](#control-buttons)
  + [Controller](#controller)
  + [Autoplay](#autoplay)


### Installation

Add 

```bash

flutter_swiper : ^0.0.8

```
to your pubspec.yaml ,and run 

```bash
flutter packages get 
```
in your project's root directory.

### Basic Usage

Create a new project with command

```
flutter create myapp
```

Edit lib/main.dart like this:

```

import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
    body:  new Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}

```



### Constructor


#### Basic

| Parameter  | Default   | Description |
| :------------ |:---------------:| :-----|
| scrollDirection | Axis.horizontal  | If `Axis.horizontal`, the scroll view's children are arranged horizontally in a row instead of vertically in a column. |
| loop | true |Set to `false` to disable continuous loop mode. |
| index | 0 |  Index number of initial slide. |
| autoplay | false |Set to `true` enable auto play mode. |
| onIndexChanged | void onIndexChanged(int index)  | Called with the new index when the user swiped or autoplay |
| onTap | void onTap(int index)  | Called when user tap ui. |
| duration | 300.0  | The milliscends of every transaction animation costs  |
| pagination | null | set `new SwiperPagination()` to show default pagination
| control | null | set `new SwiperControl()` to show default control buttons


#### Pagination

The pagination extends from `SwiperPlugin`,the `SwiperPlugin` provides extra ui for `Swiper`.Set `new SwiperPagination()` to show default pagination.


| Parameter  | Default   | Description |
| :------------ |:---------------:| :-----|
| alignment | Alignment.bottomCenter  | Change this value if you what to put pagination in other place |
| margin | const EdgeInsets.all(10.0) | The distance between inner side of the parent container. |
| builder | SwiperPagination.dots | There are two default styles `SwiperPagination.dots` and `SwiperPagination.fraction`,both can be customized. |

If you'd like to customize your own pagination, you can do like this:

```
new Swiper(
    ...,
    pagination:new SwiperCustomPagination(
        builder:(BuildContext context, SwiperPluginConfig config){
            return new YourOwnPaginatipon();
        }
    )
);

```



#### Control buttons

The control also extends from `SwiperPlugin`,set `new SwiperControl()` to show default control buttons.


| Parameter  | Default   | Description |
| :------------ |:---------------:| :-----|
| iconPrevious | Icons.arrow_back_ios  | The icon data to display `previous` control button |
| iconNext | Icons.arrow_forward_ios | The icon data to display `next`. |
| color | Theme.of(context).primaryColor | Control button color |
| size | 30.0 | Control button size |
| padding | const EdgeInsets.all(5.0) | Control button padding |


#### Controller

The `Controller` is used to control the `index` of the Swiper, start or stop autoplay.You can create a controller by `new SwiperController()` and save the instance by futher usage.


| Method  | Description |
| :------------ |:-----|
| void move(int index, {bool animation: true}) | Move to the spicified `index`,with animation or not |
| void next({bool animation: true}) | Move to next |
| void previous({bool animation: true}) | Move to previous |
| void startAutoplay() | Start autoplay |
| void stopAutoplay() | Stop autoplay |



#### Autoplay

| Parameter  | Default   | Description |
| :------------ |:---------------:| :-----|
| autoplayDely | 3000  | Autoplay delay milliseconds. |
| autoplayDiableOnInteraction | true | Disable autoplay when user drag. |


