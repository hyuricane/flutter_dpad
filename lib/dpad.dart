library dpad;

import 'package:flutter/material.dart';
import 'dart:math';

enum DpadState {
  IDLE,
  CENTER_PRESSED,
  LEFT_PRESSED,
  UP_PRESSED,
  RIGHT_PRESSED,
  DOWN_PRESSED
}

class Dpad extends StatefulWidget {

  final Function(DpadState state) keyPadDown;
  final Function(DpadState state, bool canceled) keyPadUp;

  final ImageProvider idleImg;
  final ImageProvider leftImg;
  final ImageProvider upImg;
  final ImageProvider rightImg;
  final ImageProvider downImg;
  final ImageProvider okImg;
  final ImageProvider okPressedImg;
  final double centerRatio;

  Dpad({
    @required this.keyPadDown,
    @required this.keyPadUp,
    this.idleImg = const AssetImage('assets/dpad_b.png', package: 'dpad'),
    this.leftImg = const AssetImage('assets/dpad_left.png', package: 'dpad'),
    this.upImg = const AssetImage('assets/dpad_top.png', package: 'dpad'),
    this.rightImg = const AssetImage('assets/dpad_right.png', package: 'dpad'),
    this.downImg = const AssetImage('assets/dpad_bottom.png', package: 'dpad'),
    this.okImg = const AssetImage('assets/dpad_ok.png', package: 'dpad'),
    this.okPressedImg = const AssetImage('assets/dpad_okc.png', package: 'dpad'),
    this.centerRatio = 0.25
  });
  
  @override
  State<StatefulWidget> createState() {
    return new _Dpad();
  }
}

class _Dpad extends State<Dpad> {
  DpadState _state = DpadState.IDLE;

  Widget _currentImage(BuildContext context){
    switch(_state){
      case DpadState.CENTER_PRESSED: return _centerImg(context); break;
      case DpadState.LEFT_PRESSED: return _leftImg(context); break;
      case DpadState.UP_PRESSED: return _upImg(context); break;
      case DpadState.RIGHT_PRESSED: return _rightImg(context); break;
      case DpadState.DOWN_PRESSED: return _downImg(context); break;
      default: return _idleImg(context); break;
    }
  }

  Widget _leftImg(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: widget.leftImg
        )
      ),
      child: Center(
        heightFactor: widget.centerRatio,
        widthFactor: widget.centerRatio,
        child: Image(image: widget.okImg, fit: BoxFit.contain, gaplessPlayback: true),
      ),
    );
  }
  Widget _upImg(BuildContext context){

    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: widget.upImg
        )
      ),
      child: Center(
        heightFactor: widget.centerRatio,
        widthFactor: widget.centerRatio,
        child: Image(image: widget.okImg, fit: BoxFit.contain, gaplessPlayback: true),
      ),
    );
  }

  Widget _rightImg(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: widget.rightImg
        )
      ),
      child: Center(
        heightFactor: widget.centerRatio,
        widthFactor: widget.centerRatio,
        child: Image(image: widget.okImg, fit: BoxFit.contain, gaplessPlayback: true),
      ),
    );
  }

  Widget _downImg(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: widget.downImg
        )
      ),
      child: Center(
        heightFactor: widget.centerRatio,
        widthFactor: widget.centerRatio,
        child: Image(image: widget.okImg, fit: BoxFit.contain, gaplessPlayback: true),
      ),
    );
  }

  Widget _centerImg(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: widget.idleImg
        )
      ),
      child: Center(
        heightFactor: widget.centerRatio,
        widthFactor: widget.centerRatio,
        child: Image(image: widget.okPressedImg, fit: BoxFit.contain, gaplessPlayback: true),
      ),
    );
  }

  Widget _idleImg(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: widget.idleImg
        )
      ),
      child: Center(
        heightFactor: 2.0,
        widthFactor: 2.0,
        child: Image(image: widget.okImg, fit: BoxFit.contain, gaplessPlayback: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        onTapUp: (TapUpDetails detail) {
          widget.keyPadUp(_state, false);
          setState(() {
            _state = DpadState.IDLE;
          });
        },
        onTapDown: (TapDownDetails detail) {
          RenderBox getBox = context.findRenderObject();
          var localPosition = getBox.globalToLocal(detail.globalPosition);
          int area = areaPressed(localPosition, context.size);
          var s = _state;
          if (area != -1){
            if (area == 0){
              s = DpadState.CENTER_PRESSED;
            } else if (area == 1) {
              s = DpadState.LEFT_PRESSED;
            } else if (area == 2) {
              s = DpadState.UP_PRESSED;
            } else if (area == 3) {
              s = DpadState. RIGHT_PRESSED;
            } else if (area == 4) {
              s = DpadState.DOWN_PRESSED;
            }
          }
          setState(() {
            _state = s;
          });

          widget.keyPadDown(s);
        },
        onTapCancel: (){
          widget.keyPadUp(_state, true);
          setState(() {
            _state = DpadState.IDLE;
          });
        },
        child: _currentImage(context),
      ),
    );
  }

  int areaPressed(Offset offset, Size size){
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    double centerR2 = pow((min(centerX, centerY) * widget.centerRatio), 2);
    double ringR2 = pow((min(centerX, centerY)), 2);

    double rX = offset.dx - centerX;
    double rY = offset.dy - centerY;

    double rX2 = pow(rX, 2);
    double rY2 = pow(rY, 2);

    if (centerR2 > rX2 + rY2){ // center
      return 0;
    } else if (ringR2 >  rX2 + rY2){ // direction
      if (rX2 > rY2){ // left or right
        return rX < 0 ? 1 : 3;
      } else{ // up or down
        return rY < 0 ? 2 : 4;
      }
    } else { // ignore
      return -1;
    }
  }
}
