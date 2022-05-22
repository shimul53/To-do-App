import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:todo_app/services/theme_services.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Text("Theme Data",style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(

        onTap: (){

          ThemeService().switchTheme();



        },
        child: Icon(Get.isDarkMode? Icons.wb_sunny_outlined : Icons.nightlight_round,size: 20,color: Get.isDarkMode? Colors.white:Colors.black,),
      ),
      actions: [
        Icon(Get.isDarkMode? Icons.search : Icons.search,size: 25,color: Get.isDarkMode? Colors.white:Colors.black,),
        SizedBox(width: 20,)
      ],
    );
  }
}
