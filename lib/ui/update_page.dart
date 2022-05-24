/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/ui/theme.dart';
class UpdatePage extends StatelessWidget {
   final String
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
                        Text(this.label.toString().split("|")[0],
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
                        Text(this.label.toString().split("|")[1],
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
                        Text(this.label.toString().split("|")[2],
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
                          "${this.label.toString().split("|")[3]} - ${this.label.toString().split("|")[4]} ",
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
                          "${this.label.toString().split("|")[5]} Minutes early",
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
                          this.label.toString().split("|")[6],
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
}*/

import 'package:flutter/material.dart';
import 'package:todo_app/models/taskModel.dart';



class UpdatePage extends StatelessWidget {
  const UpdatePage({
    Key? key,
    required this.data,
    required this.edit,
    required this.index,
    required this.delete,
  }) : super(key: key);
  final TaskModel data;
  final Function edit;
  final Function delete;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: IconButton(
              onPressed: () {
                edit(index);
              },
              icon: Icon(Icons.edit)),
        ),
        title: Text(data.title.toString()),
        subtitle: Text(data.note.toString()),
        trailing: CircleAvatar(
            backgroundColor: Colors.red,
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                delete(index);
              },
            )),
      ),
    );
  }
}
