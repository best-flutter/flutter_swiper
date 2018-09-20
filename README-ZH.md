语言 : [English](https://github.com/jzoom/flutter_swiper) | [中文](https://github.com/jzoom/flutter_swiper/blob/master/README-ZH.md)

[![build_status](https://travis-ci.org/jzoom/flutter_swiper.svg?branch=master)](https://travis-ci.org/jzoom/flutter_swiper)
[![Coverage Status](https://coveralls.io/repos/github/jzoom/flutter_swiper/badge.svg?branch=master)](https://coveralls.io/github/jzoom/flutter_swiper?branch=master)
[![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen.svg)](https://github.com/jzoom/flutter_swiper/pulls)
[![pub package](https://img.shields.io/pub/v/flutter_swiper.svg)](https://pub.flutter-io.cn/packages/flutter_swiper)


# flutter_swiper

flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配.


# :sparkles::sparkles: 新功能


![](https://github.com/jzoom/images/raw/master/layout1.gif)

![](https://github.com/jzoom/images/raw/master/layout2.gif)

![](https://github.com/jzoom/images/raw/master/layout3.gif)

[更多](#内建的布局)


# 截图

![Horizontal](https://github.com/jzoom/flutter_swiper/raw/master/example/res/1.gif)

![Vertical](https://github.com/jzoom/flutter_swiper/raw/master/example/res/2.gif)

![Custom Pagination](https://github.com/jzoom/flutter_swiper/raw/master/example/res/3.gif)

![Custom Pagination](https://github.com/jzoom/flutter_swiper/raw/master/example/res/4.gif)

![Phone](https://github.com/jzoom/flutter_swiper/raw/master/example/res/5.gif)

![Example](https://github.com/jzoom/images/raw/master/swiper-example.gif)

[更多](#代码)

## 功能路线

1.x.x 功能实现：

- [x] 无限循环轮播
- [x] 控制按钮
- [x] 分页指示器
- [x] 非无限循环模式
- [x] 单元测试
- [x] 例子
- [x] 滚动方向
- [x] 可定制控制按钮
- [x] 可定制分页
- [x] 自动播放
- [x] 控制器
- [x] 外部分页指示器
- [ ] 更多布局方式


## 更新日志

>参考:[CHANGELOG.md](https://github.com/jzoom/flutter_swiper/blob/master/CHANGELOG-ZH.md)

## 目录

- [安装](#安装)
- [基本使用](#基本使用)
- [构建](#构建)
  + [基本构造函数](#基本构造函数)
  + [分页指示器](#分页指示器)
  + [控制按钮](#控制按钮)
  + [控制器](#控制器)
  + [自动播放](#自动播放)
+ [内建的布局](#内建的布局)
+ [一些常用代码示例](#代码)

### 安装

增加

```bash

flutter_swiper : ^lastest_version

```
到项目根目录下的 pubspec.yaml ,并且根目录运行命令行 

```bash
flutter packages get 
```


### 基本使用

使用命令行创建一个新项目:

```
flutter create myapp
```

编辑 lib/main.dart:

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



### 构建


#### 基本参数

| 参数            | 默认值             |           描述     |
| :-------------- |:-----------------:| :------------------------|
| scrollDirection | Axis.horizontal  |滚动方向，设置为Axis.vertical如果需要垂直滚动   |
| loop            | true             |无限轮播模式开关                              |
| index           | 0                |初始的时候下标位置                            |
| autoplay        | false             |自动播放开关. |
| onIndexChanged  | void onIndexChanged(int index)  | 当用户手动拖拽或者自动播放引起下标改变的时候调用 |
| onTap           | void onTap(int index)  | 当用户点击某个轮播的时候调用 |
| duration        | 300.0            | 动画时间，单位是毫秒 |
| pagination      | null             | 设置 `new SwiperPagination()` 展示默认分页指示器
| control | null | 设置 `new SwiperControl()` 展示默认分页按钮


#### 分页指示器

分页指示器继承自 `SwiperPlugin`,`SwiperPlugin` 为 `Swiper` 提供额外的界面.设置为`new SwiperPagination()` 展示默认分页.


| 参数            | 默认值             |           描述     |
| :------------ |:---------------:| :-----|
| alignment | Alignment.bottomCenter  | 如果要将分页指示器放到其他位置，那么可以修改这个参数 |
| margin | const EdgeInsets.all(10.0) | 分页指示器与容器边框的距离 |
| builder | SwiperPagination.dots | 目前已经定义了两个默认的分页指示器样式： `SwiperPagination.dots` 、 `SwiperPagination.fraction`，都可以做进一步的自定义. |

如果需要定制自己的分页指示器，那么可以这样写：

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



#### 控制按钮

控制按钮组件也是继承自 `SwiperPlugin`,设置 `new SwiperControl()` 展示默认控制按钮.


| 参数            | 默认值             |           描述     |
| :------------ |:---------------:| :-----|
| iconPrevious | Icons.arrow_back_ios  | 上一页的IconData |
| iconNext | Icons.arrow_forward_ios | 下一页的IconData |
| color | Theme.of(context).primaryColor | 控制按钮颜色 |
| size | 30.0                           | 控制按钮的大小 |
| padding | const EdgeInsets.all(5.0) | 控制按钮与容器的距离 |


#### 控制器(SwiperController)

`SwiperController` 用于控制 Swiper的`index`属性, 停止和开始自动播放. 通过 `new SwiperController()` 创建一个SwiperController实例，并保存，以便将来能使用。


| 方法            | 描述     |
| :------------ |:-----|
| void move(int index, {bool animation: true}) | 移动到指定下标，设置是否播放动画|
| void next({bool animation: true}) | 下一页 |
| void previous({bool animation: true}) | 上一页 |
| void startAutoplay() | 开始自动播放 |
| void stopAutoplay() | 停止自动播放 |



#### 自动播放

| 参数            | 默认值             |           描述     |
| :------------ |:---------------:| :-----|
| autoplayDely | 3000  | 自动播放延迟毫秒数. |
| autoplayDisableOnInteraction | true | 当用户拖拽的时候，是否停止自动播放. |



## 内建的布局
![](https://github.com/jzoom/images/raw/master/layout1.gif)

```
new Swiper(
  itemBuilder: (BuildContext context, int index) {
    return new Image.network(
      "http://via.placeholder.com/288x188",
      fit: BoxFit.fill,
    );
  },
  itemCount: 10,
  viewportFraction: 0.8,
  scale: 0.9,
)

```



![](https://github.com/jzoom/images/raw/master/layout2.gif)

```
new Swiper(
  itemBuilder: (BuildContext context, int index) {
    return new Image.network(
      "http://via.placeholder.com/288x188",
      fit: BoxFit.fill,
    );
  },
  itemCount: 10,
  itemWidth: 300.0,
  layout: SwiperLayout.STACK,
)
```

![](https://github.com/jzoom/images/raw/master/layout3.gif)

```
new Swiper(
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        "http://via.placeholder.com/288x188",
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

构建你自己的动画十分简单:
```

 new Swiper(
  layout: SwiperLayout.CUSTOM,
  customLayoutOption: new CustomLayoutOption(
      startIndex: -1,
      stateCount: 3
  ).addRotate([
    -45.0/180,
    0.0,
    45.0/180
  ]).addTranslate([
    new Offset(-370.0, -40.0),
    new Offset(0.0, 0.0),
    new Offset(370.0, -40.0)
  ]),
  itemWidth: 300.0,
  itemHeight: 200.0,
  itemBuilder: (context, index) {
    return new Container(
      color: Colors.grey,
      child: new Center(
        child: new Text("$index"),
      ),
    );
  },
  itemCount: 10)

```

`CustomLayoutOption` 被设计用来描述布局和动画,很简单的可以指定每一个元素的状态.

```
new CustomLayoutOption(
      startIndex: -1,  /// 开始下标
      stateCount: 3    /// 下面的数组长度 
  ).addRotate([        //  每个元素的角度
    -45.0/180,
    0.0,
    45.0/180
  ]).addTranslate([           /// 每个元素的偏移
    new Offset(-370.0, -40.0),
    new Offset(0.0, 0.0),
    new Offset(370.0, -40.0)
  ])

```

## 代码


![Example](https://github.com/jzoom/images/raw/master/swiper-example.gif)

```
new ConstrainedBox(
  child: new Swiper(
    outer:false,
    itemBuilder: (c, i) {
      return new Wrap(
        runSpacing:  6.0,
        children: [0,1,2,3,4,5,6,7,8,9].map((i){
          return new SizedBox(
            width: MediaQuery.of(context).size.width/5,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new SizedBox(
                  child:  new Container(
                    child: new Image.network("https://fuss10.elemecdn.com/c/db/d20d49e5029281b9b73db1c5ec6f9jpeg.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90"),
                  ),
                  height: MediaQuery.of(context).size.width * 0.12,
                  width: MediaQuery.of(context).size.width * 0.12,
                ),
                new Padding(padding: new EdgeInsets.only(top:6.0),child: new Text("$i"),)
              ],
            ),
          );
        }).toList(),
      );
    },
    pagination: new SwiperPagination(
      margin: new EdgeInsets.all(5.0)
    ),
    itemCount: 10,
  ),
    constraints:new BoxConstraints.loose(new Size(screenWidth, 170.0))
),

```



这里可以找到所有的定制选项

>https://github.com/jzoom/flutter_swiper/blob/master/example/lib/src/ExampleCustom.dart