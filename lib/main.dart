import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/model/task_model.dart';
import 'core/services/local_storage.dart';
import 'core/utils/colors.dart';
import 'core/utils/themes.dart';
import 'feature/info/splash_view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('taskBox');
  AppLocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    return ValueListenableBuilder(
      valueListenable: AppLocalStorage.userBox.listenable(),
      builder: (BuildContext context, Box<dynamic> value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode:
              AppLocalStorage.getCachedData(AppLocalStorage.kIsDarkMode) ??
                      false
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home: const SplashView(),
        );
      },
    );
  }
}
