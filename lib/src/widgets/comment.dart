import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import 'package:flutter_html_widget/flutter_html_widget.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return ListTile(title: Text('Still loading comment'),);

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by == '' ? Text('Deleted comment') : Text(item.by),
            contentPadding: EdgeInsets.only(left: 16.0 * depth, right: 16.0),
          ),
          Divider(),
        ];
        item.kids.forEach((kidsId) {
          children.add(
            Comment(
              itemId: kidsId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item){
    return HtmlWidget(
      html: item.text,
    );
//    return HtmlView(
//      data: item.text,
//    );
  }
}
