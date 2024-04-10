import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scent_shop/constants/theme.dart';
import 'package:scent_shop/firebase_helper/firebase_auth_helper/firebase_firestore/firebase_auth_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scent_shop/firebase_helper/firebase_option/firebase_options.dart';
import 'package:scent_shop/provider/app_provider.dart';
import 'package:scent_shop/screens/auth_ui/welcome/welcome.dart';
import 'package:scent_shop/screens/custom_bottem/custom_bottem_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scent',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottem();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
