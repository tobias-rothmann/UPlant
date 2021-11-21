import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uplant/modules/projects/projects_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.green,
          primary: Colors.green,
        ),
        textTheme: GoogleFonts.interTextTheme().copyWith(
          headline4: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline5: GoogleFonts.inter(fontWeight: FontWeight.bold),
          headline6: GoogleFonts.inter(
            decoration: TextDecoration.underline,
            decorationColor: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // darkTheme: ThemeData.dark().copyWith(
      //     colorScheme: ColorScheme.fromSwatch().copyWith(
      //   secondary: Colors.green,
      //   primary: Colors.green,
      // )),
      themeMode: ThemeMode.light,
      home: ProjectsView(),
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthService());
        },
      ),
    );
  }
}
