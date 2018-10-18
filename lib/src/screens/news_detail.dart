import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/models/item_model.dart';

class NewsDetail extends StatelessWidget {
  final int id;

  NewsDetail({@required this.id});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {

      },
    );
  }
}
