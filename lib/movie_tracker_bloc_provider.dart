import 'package:flutter/material.dart';
import 'package:flutter_world/movie_tracker_bloc.dart';

class MovieTrackerBlocProvider extends StatefulWidget {
  final Widget child;
  final MovieTrackerBloc bloc;

  MovieTrackerBlocProvider({Key key, this.child, this.bloc}) : super(key: key);

  static MovieTrackerBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedContainer)
            as _InheritedContainer)
        .bloc;
  }

  @override
  _MovieTrackerProviderState createState() {
    return _MovieTrackerProviderState();
  }
}

class _MovieTrackerProviderState extends State<MovieTrackerBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _InheritedContainer(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    //widget.bloc.close();
    super.dispose();
  }
}

class _InheritedContainer extends InheritedWidget {
  final MovieTrackerBloc bloc;

  _InheritedContainer({
    Key key,
    MovieTrackerBloc bloc,
    Widget child,
  })  : this.bloc = bloc ?? MovieTrackerBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedContainer oldWidget) {
    //return bloc != oldWidget.bloc;
    return true;
  }
}
