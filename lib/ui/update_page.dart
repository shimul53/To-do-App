import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/ui/theme.dart';
class UpdatePage extends StatelessWidget {

  const UpdatePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode?Colors.grey[600]: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios,color:Get.isDarkMode? Colors.white:Colors.grey,),
        ),
        title: Text("Task Manager",style: TextStyle(color: Get.isDarkMode? Colors.white: Colors.black),),
      ),
      body: Center(
        child: Container(
          height:  520,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode?primaryClr:greenClr,
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.subtitles,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Tittle",
                          style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text("Hi Shimul",
                          style: TextStyle(color: Colors.white,fontSize: 16),),
                      ],

                    ),
                  ],
                ),

                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Description",
                          style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text("I am a developer",
                          style: TextStyle(color: Colors.white,fontSize: 16),),
                      ],

                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Date",
                          style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text("23-05-2022",
                          style: TextStyle(color: Colors.white,fontSize: 16),),
                      ],

                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Time",
                          style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text(
                          "10:00 - 11:00",
                          style: TextStyle(color: Colors.white,fontSize: 16),),


                      ],

                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Remind",
                          style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text(
                          "5 Minutes early",
                          style: TextStyle(color: Colors.white,fontSize: 16),),


                      ],

                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.repeat,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Repeat",
                          style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text(
                          "10 min",
                          style: TextStyle(color: Colors.white,fontSize: 16),),


                      ],

                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
