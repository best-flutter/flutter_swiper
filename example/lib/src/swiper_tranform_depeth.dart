import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'src/ExampleCustom.dart';
import 'src/config.dart';
import 'src/ExampleSwiperInScrollView.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget buildHome() {
    List<Color> colors = [
      Colors.green,
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.red
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(""),
      ),
      body: new Container(
        color: Colors.black87,
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 300.0,
              child: Swiper(
                  itemWidth: 300.0,
                  loop: true,
                  itemHeight: 200.0,
                  transformItemBuilder: (Widget child, double position) {
                    double pageWidth = 375.0;
                    print(position);
                    if(position <= 0){
                      return new Opacity(
                        opacity: 1.0,
                        child: new Transform.translate(
                          offset: new Offset(0.0, 0.0),
                          child: new Transform.scale(
                            scale: 1.0,
                            child: child,
                          ),
                        ),
                      );
                    }else if (position <= 1) {
                      const double MIN_SCALE = 0.75;
                      // Scale the page down (between MIN_SCALE and 1)
                      double scaleFactor =
                          MIN_SCALE + (1 - MIN_SCALE) * (1 - position);

                      return new Opacity(
                        opacity: 1.0 - position ,
                        child: new Transform.translate(
                          offset: new Offset(pageWidth * -position, 0.0),
                          child: new Transform.scale(
                            scale: scaleFactor,
                            child: child,
                          ),
                        ),
                      );
                    }

                    return child;
                  },
                  itemBuilder: (context, index) {
                    return new Container(
                      color: colors[index % colors.length],
                      child: new Center(
                        child: new Text("$index"),
                      ),
                    );
                  },
                  itemCount: 10),
            )
          ],
        ),
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: new MyHomePage(title: 'Flutter Swiper'),
      home: buildHome(),

    );
  }
}
