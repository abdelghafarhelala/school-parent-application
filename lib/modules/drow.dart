import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parent_app/shared/colors.dart';

class DrawScreen extends StatelessWidget {
  const DrawScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
              width: double.infinity,
              height: 280,
              child: CustomPaint(
                painter: CustomPainterTop(),
              )),
          const Spacer(),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: CustomPaint(
              painter: CustomPainterBottom(),
            ),
          )
        ],
      ),
    );
  }
}

class CustomPainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final paint = Paint()..color = primaryColor;
    paint.style = PaintingStyle.fill;
    // paint.strokeWidth = 10;
    var paints = Offset.zero & size;
    paint.shader = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        primaryColor,
        Color(0xFF8f94fb),
      ],
    ).createShader(paints);
    path.moveTo(0, size.height);
    // path.lineTo(size.width * .2, size.height * .9);
    path.quadraticBezierTo(
        size.width * .10, size.height, size.width * 0.13, size.height * .6);
    path.quadraticBezierTo(
        size.width * .20, size.height * .20, size.width * .5, size.height * .4);
    path.quadraticBezierTo(
        size.width * .8, size.height * .53, size.width * .95, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class CustomPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    var paints = Offset.zero & size;
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.deepOrange[700]!,
        Colors.deepOrange[200]!,
      ],
    ).createShader(paints);
    final path = Path();
    path.moveTo(size.width * .2, size.height);
    path.quadraticBezierTo(
        size.width * .2, size.height * .9, size.width * .4, size.height * .8);
    path.quadraticBezierTo(size.width * .7, size.height * .7, size.width, 0);
    ;
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
