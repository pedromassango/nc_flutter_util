import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => new _DemoPageState();

  DemoPage() {
    timeDilation = 1.0;
  }
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new DemoBody(screenSize: MediaQuery.of(context).size),
    );
  }
}

class DemoBody extends StatefulWidget {
  final Size screenSize;

  DemoBody({Key key, @required this.screenSize}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _DemoBodyState();
  }
}

class _DemoBodyState extends State<DemoBody> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        animationController.forward();
      } else if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new CustomPaint(
              size: new Size(
                widget.screenSize.width,
                widget.screenSize.height,
              ),
              painter: new _DemoPainter(widget.screenSize),
            ),
      ),
    );
  }
}

class _DemoPainter extends CustomPainter {
  final Size screenSize;

  _DemoPainter(this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
  }

  @override
  bool shouldRepaint(_DemoPainter oldDelegate) => true;
}