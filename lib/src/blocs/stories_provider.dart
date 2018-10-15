import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
export 'package:news/src/blocs/stories_bloc.dart';

class StoriesProvider extends InheritedWidget {

  static StoriesBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(StoriesProvider) as StoriesProvider).bloc;
  }


  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
