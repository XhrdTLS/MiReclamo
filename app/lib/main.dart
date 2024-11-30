import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mi_reclamo/core/widgets/styles/theme.dart';
import 'package:mi_reclamo/features/presentation/pages/login/login_page.dart';
import 'core/core.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, 
    statusBarIconBrightness: Brightness.dark, 
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Mi Reclamo UTEM',
      theme: AppTheme.getLight(context),
      darkTheme: AppTheme.getDark(context),
      home: const SafeArea(
        child:  LoginPage(),
      ),
    );
  }
}
