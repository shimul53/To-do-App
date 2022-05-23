import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/home_page.dart';
import 'package:todo_app/ui/onboarding_page.dart';
import 'package:todo_app/ui/theme.dart';

int? initScreen;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDatabase();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
     initialRoute: initScreen ==0 || initScreen == null?  'onboard':'home',
      routes: {
        'home': (context) => HomePage(),
        'onboard': (context) => OnboardingPage(),
      },
    );
  }
}
