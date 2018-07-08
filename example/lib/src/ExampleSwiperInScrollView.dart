import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ExampleSwiperInScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate((c, i) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                    itemBuilder: (c, i) {
                      return Container(
                        color: Colors.grey,
                        child: Text("$i"),
                      );
                    },
                    itemCount: 10,
                    pagination: SwiperPagination(),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination:
                          SwiperPagination(builder: SwiperPagination.fraction),
                      itemCount: 10000),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination: SwiperPagination(),
                      itemCount: 10),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination:
                          SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                Swiper(
                  containerHeight: 100.0,
                  outer: true,
                  itemBuilder: (c, i) {
                    return Container(
                      color: Colors.grey,
                      child: Text("$i"),
                    );
                  },
                  pagination: SwiperPagination(),
                  itemCount: 10,
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                    itemBuilder: (c, i) {
                      return Container(
                        color: Colors.grey,
                        child: Text("$i"),
                      );
                    },
                    pagination: SwiperPagination(),
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
