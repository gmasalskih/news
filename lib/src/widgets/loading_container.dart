import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(''),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.star, color: Colors.amber),
            Text('')
          ],
        ),
        trailing: Column(
          children: <Widget>[
            Icon(Icons.comment, color: Colors.green),
            Text(''),
          ],
        ),
      ),
    );
  }
}