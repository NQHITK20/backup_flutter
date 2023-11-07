import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/profile.dart';
import 'package:flutter_application_3/providers/loginviewmodal.dart';
import 'package:flutter_application_3/providers/registerviewmodal.dart';
import 'package:flutter_application_3/service/api_service.dart';
import 'package:flutter_application_3/ui/page_login.dart';
import 'package:flutter_application_3/ui/page_main.dart';
import 'package:flutter_application_3/ui/page_register.dart';
import 'package:provider/provider.dart';

void main() {
  ApiService api = ApiService();
  api.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  Profile profile = Profile();
  profile.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginViewModal>(
          create: (context) => LoginViewModal()),
      ChangeNotifierProvider<RegisterViewModel>(
          create: (context) => RegisterViewModel())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => Pagemain(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageRegister(),
    );
  }
}

class padding1 extends StatelessWidget {
  const padding1({
    super.key,
    required TextEditingController emailController,
    required this.hintText,
    required this.obscureText,
  }) : _emailController = emailController;

  final TextEditingController _emailController;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: TextField(
          obscureText: obscureText,
          controller: _emailController,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: hintText),
        ),
      ),
    );
  }
}
