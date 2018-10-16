import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Card(
            child: LoadingContainer(),
          );
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Card(
      child: ListTile(
        title: Text(item.title),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.star, color: Colors.amber),
            Text('${item.score}')
          ],
        ),
        trailing: Column(
          children: <Widget>[
            Icon(Icons.comment, color: Colors.green),
            Text('${item.descendants}'),
          ],
        ),
      ),
    );
//    return ListTile(
//      title: Text(item.title),
//      subtitle: Text('${item.score} points'),
//      trailing: Column(
//        children: <Widget>[
//          Icon(Icons.comment),
//          Text('${item.descendants}')
//        ],
//      ),
//    );
  }
}
