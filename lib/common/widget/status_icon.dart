import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_jenkins/global/tool/logger.dart';

class StatusIcon extends StatefulWidget {
  final String color;

  StatusIcon(this.color);

  @override
  _StatusIconState createState() => _StatusIconState(this.color);
}

class _StatusIconState extends State<StatusIcon> with TickerProviderStateMixin {
  final String color;
  bool _isAnime = false;
  Color _mtrColor = Colors.deepPurple;
  bool _isUnknownStatus = false;

  AnimationController controller; // 动画控制器
  CurvedAnimation curved; // 曲线动画，动画插值，

  final color2Mtr = const {
    "blue": Colors.green,
    "notbuilt": Colors.grey,
    "disabled": Colors.black87,
    "yellow": Colors.yellow,
    "red": Colors.red,
  };

  _StatusIconState(this.color) {
    logger.i("_StatusIconState#color:${this.color}");
    if (this.color == null || this.color.isEmpty) {
      this._isUnknownStatus = true;
    } else {
      String realColor = color;
      if (this.color.endsWith('_anime')) {
        this._isAnime = true;
        final index = this.color.indexOf('_anime');
        realColor = this.color.substring(0, index);
      }
      this._mtrColor = color2Mtr[realColor];
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO 动画待调试
    controller = AnimationController(
        lowerBound: 0.2,
        upperBound: 1.0,
        vsync: this,
        duration: Duration(seconds: 3),
        reverseDuration: Duration(seconds: 3));
    curved = CurvedAnimation(
        parent: controller,
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut);
    if (_isAnime) {
      // 启动动画
      controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (this._isUnknownStatus) {
      widget = Icon(FontAwesomeIcons.solidQuestionCircle);
    } else if (this._isAnime) {
      widget = FadeTransition(
        opacity: curved,
        child: Icon(
          FontAwesomeIcons.solidCircle,
          color: this._mtrColor,
        ),
      );
    } else {
      widget = Icon(
        FontAwesomeIcons.solidCircle,
        color: this._mtrColor,
      );
    }
    return widget;
  }
}
