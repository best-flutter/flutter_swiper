import 'package:flutter/material.dart';

class DotsPagination extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Axis direction;
  final double space;
  final int index;
  final int itemCount;

  DotsPagination(
      {this.padding: const EdgeInsets.all(10.0),
      this.space: 3.0,
      this.index,
      this.itemCount,
      this.direction: Axis.horizontal});

  Widget buildItem(int index, int itemCount, bool active) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Pagination(
      padding: padding,
      direction: direction,
      itemBuilder: buildItem,
      space: space,
      itemCount: itemCount,
      index: index,
    );
  }
}

typedef Widget PaginationItemBuilder(int index, int itemCount, bool active);

class Pagination extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final PaginationItemBuilder itemBuilder;
  final Axis direction;
  final double space;
  final int index;
  final int itemCount;

  Pagination({
    this.space: 3.0,
    this.direction: Axis.horizontal,
    this.itemBuilder,
    this.padding: const EdgeInsets.all(10.0),
    this.index,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final EdgeInsets margin = new EdgeInsets.only(left: space);

    List list = [];
    for (int i = 0; i < itemCount; ++i) {
      Widget child = itemBuilder(i, itemCount, index == i);
      if (i > 0) {
        child = new Container(
          margin: margin,
          child: child,
        );
      }
      list.add(child);
    }

    Widget child = direction == Axis.vertical
        ? new Column(mainAxisSize: MainAxisSize.min, children: list)
        : new Row(
            mainAxisSize: MainAxisSize.min,
            children: list,
          );
    return new Padding(padding: padding, child: child);
  }
}
