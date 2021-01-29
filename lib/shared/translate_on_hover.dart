import 'package:flutter/material.dart';

class TranslateOnHover extends StatefulWidget {
  final Widget child;
  TranslateOnHover({Key key, this.child}): super(key: key);
  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  final nonHoverTransForm = Matrix4.identity();
  final hoverTransForm = Matrix4.identity()..translate(0, -4, 0);

  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _mouseEnter(true),
      onExit: (event) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: widget.child,
        transform: _hovering ? hoverTransForm: nonHoverTransForm,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}