import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ExampleSwiperInScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return new Container(
      color: Theme.of(context).primaryColorLight,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: new SliverChildBuilderDelegate((c, i) {
            return new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new SizedBox(
                  height: 100.0,
                  child: Swiper(
                    itemBuilder: (c, i) {
                      return Container(
                        color: Colors.grey,
                        child: Text("$i"),
                      );
                    },
                    itemCount: 10,
                    pagination: new SwiperPagination(),
                  ),
                ),
                new SizedBox(
                  height: 100.0,
                  child: Swiper(
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination:
                      new SwiperPagination(builder: SwiperPagination.fraction),
                      itemCount: 10000),
                ),
                new SizedBox(
                  height: 100.0,
                  child: Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return new Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination: SwiperPagination(),
                      itemCount: 10),
                ),
                new SizedBox(
                  height: 100.0,
                  child: new Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination:
                      new  SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                new Swiper(
                  containerHeight: 100.0,
                  outer: true,
                  itemBuilder: (c, i) {
                    return Container(
                      color: Colors.grey,
                      child: Text("$i"),
                    );
                  },
                  pagination: new SwiperPagination(),
                  itemCount: 10,
                ),
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
                new SizedBox(
                  height: 100.0,
                  child: new Swiper(
                    itemBuilder: (c, i) {
                      return Container(
                        color: Colors.grey,
                        child: Text("$i"),
                      );
                    },
                    pagination: new SwiperPagination(),
                    itemCount: 10,
                  ),
                ),
              ],
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}
