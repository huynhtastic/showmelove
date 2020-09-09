import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  final String title;
  final Widget body;

  AnimatedFab({@required this.title, @required this.body});

  @override
  _AnimatedFabState createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (_, openContainer) => FloatingActionButton(
        key: Key('newPost'),
        onPressed: openContainer,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      openColor: Colors.blue,
      closedElevation: 5.0,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      closedColor: Colors.blue,
      openBuilder: (_, closeContainer) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(widget.title),
            leading: IconButton(
              onPressed: closeContainer,
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: widget.body,
        );
      },
    );
  }
}
