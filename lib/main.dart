import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/style/theme.dart';
import 'data/localstorage.dart';
import 'ui/screens/task_screen.dart';

void main() async {
  // ignore: unused_local_variable
  LocalStorage? db = LocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      // themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.system,
      home: const TaskScreen(),
    );
  }
}
