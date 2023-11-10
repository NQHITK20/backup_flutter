import 'package:flutter/material.dart';
import 'package:flutter_application_3/providers/mainviewmodel.dart';
import 'package:flutter_application_3/providers/menubarviewmodal.dart';
import 'package:provider/provider.dart';

class Pagemain extends StatelessWidget {
  static String routename = '/';
  Pagemain({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodal = Provider.of<MainViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          leading: GestureDetector(
            onTap: () => viewmodal.toggleMenu(),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        drawer: Drawer(child: Text('drawer text')),
        body: SafeArea(
            child: Stack(
          children: [
            Consumer<MenuBarViewModel>(
              builder: (context, menuBarModel, child) {
                return Container(
                    color: Colors.deepPurple[300],
                    child: Center(
                      child: Text('body'),
                    ));
              },
            ),
            viewmodal.menustatus == 1
                ? Consumer<MenuBarViewModel>(
                    builder: (context, menuBarModel, child) {
                      return GestureDetector(
                          onPanUpdate: (details) {
                            menuBarModel.setOffset(details.localPosition);
                          },
                          onPanEnd: (details) {
                            menuBarModel.setOffset(Offset(0, 0));
                          },
                          child: CustomMenuBar(size: size));
                    },
                  )
                : Container(),
          ],
        )));
  }
}

class CustomMenuBar extends StatelessWidget {
  const CustomMenuBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * 0.65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    } else if (offset.dx < width) {
      kq = width + 75;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
