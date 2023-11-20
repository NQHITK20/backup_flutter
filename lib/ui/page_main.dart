import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/profile.dart';
import 'package:flutter_application_3/providers/mainviewmodel.dart';
import 'package:flutter_application_3/providers/menubarviewmodal.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';
import 'package:flutter_application_3/ui/page_dklop.dart';
import 'package:flutter_application_3/ui/page_login.dart';
import 'package:flutter_application_3/ui/subpage_diemdanh.dart';
import 'package:flutter_application_3/ui/subpage_dshocphan.dart';
import 'package:flutter_application_3/ui/subpage_dslop.dart';
import 'package:flutter_application_3/ui/subpage_profile.dart';
import 'package:flutter_application_3/ui/subpage_timkiem.dart';
import 'package:flutter_application_3/ui/subpage_tintuc.dart';
import 'package:provider/provider.dart';

class Pagemain extends StatelessWidget {
  static String routename = '/';
  Pagemain({super.key});
  final List<String> menuTitles = [
    'Tin tức',
    'Profile',
    'Điểm danh',
    'Tìm kiếm',
    'Ds lớp',
    'Ds học phần'
  ];
  final menuBar = MenuItemList();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodal = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if (profile.token == '') {
      return PageLogin();
    }
    if (profile.student.mssv == '') {
      return PageDangkyLop();
    }
    Widget body = SubPageTinTuc();
    if (viewmodal.activemenu == SubPageProfile.idpage) {
      body = SubPageProfile();
    } else if (viewmodal.activemenu == SubPageTinTuc.idpage) {
      body = SubPageTinTuc();
    } else if (viewmodal.activemenu == SubPageTimKiem.idpage) {
      body = SubPageTimKiem();
    } else if (viewmodal.activemenu == SubPageDslop.idpage) {
      body = SubPageDslop();
    } else if (viewmodal.activemenu == SubPageDshocphan.idpage) {
      body = SubPageDshocphan();
    } else if (viewmodal.activemenu == SubPageDiemdanh.idpage) {
      body = SubPageDiemdanh();
    }
    menuBar.initialize(menuTitles);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          leading: GestureDetector(
            onTap: () => viewmodal.toggleMenu(),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Consumer<MenuBarViewModel>(
              builder: (context, menuBarModel, child) {
                return Container(
                    color: Colors.deepPurple[300],
                    child: Center(
                      child: body,
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
                            viewmodal.closeMenu();
                          },
                          child: Stack(
                            children: [
                              CustomMenuBar(size: size),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: menuBar,
                              )
                            ],
                          ));
                    },
                  )
                : Container(),
          ],
        )));
  }
}

class MenuItemList extends StatelessWidget {
  MenuItemList({
    super.key,
  });

  final List<MenuBarItem> MenuBarItems = [];
  void initialize(List<String> menuTitles) {
    MenuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      MenuBarItems.add(MenuBarItem(
        idpage: i,
        containerkey: GlobalKey(),
        title: menuTitles[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size.height),
          child: SizedBox(
            height: size.height * 0.20,
            width: size.height * 0.65,
            child: Center(
              child: AvatarGlow(
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(microseconds: 100),
                endRadius: size.height * 0.3,
                glowColor: AppConstant.backgroundcolor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size.height),
                  child: SizedBox(
                    height: size.height * 0.16,
                    width: size.height * 0.16,
                    child: Image(
                      image: AssetImage('cute1.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 2,
          width: size.width * 0.55,
          color: Colors.deepPurple[300],
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: size.width * 0.6,
          width: size.width * 0.65,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MenuBarItems.length,
                itemBuilder: (context, index) {
                  return MenuBarItems[index];
                }),
          ),
        ),
      ],
    );
  }
}

class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title,
    required this.containerkey,
    required this.idpage,
  });
  final int idpage;
  final String title;
  final GlobalKey containerkey;
  TextStyle style = AppConstant.textBody;
  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textBody;
    }
    if (containerkey.currentContext != null) {
      RenderBox box =
          containerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.textBodyfocus;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textBody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanmove(menuBarModel.offset);
    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
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
