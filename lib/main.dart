import 'package:flutter/material.dart';
import 'package:optimum_music/screens/login.dart';
import 'package:optimum_music/screens/splash_screen.dart';
import 'package:optimum_music/services/my_provider.dart';
import 'package:optimum_music/utils/custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> MyProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          home: const Login()),
    );
  }
}
