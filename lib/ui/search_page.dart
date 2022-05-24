
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/taskModel.dart';
import 'package:todo_app/ui/widgets/task_tile.dart';

import '../controllers/task_conntroller.dart';
class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _taskController = Get.put(TaskController());

  TextEditingController textEditingController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  String userSearchInput = "";
  bool doItJustOnce = false;
  List<TaskModel> list=[];
  List<TaskModel> filteredList =<TaskModel>[];
  void filterList(value){
    setState(() {
      filteredList = list.where((text) => text.title!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _taskController.getTasks();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: Column(

          children:<Widget> [

            Container(
                     height: 40,
                    child: Stack(
                     children: <Widget> [


                          Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           height: 128,
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: TextFormField(
                             textAlign: TextAlign.start,
                             onChanged: (value){
                               filterList(value);
                             },
                             style: TextStyle(
                                 color: Colors.black
                             ),
                             decoration: InputDecoration(
                                 prefixIcon: Icon(Icons.search,color: Colors.blue,),
                                 hintText: "Search by title...",hintStyle: TextStyle(color: Colors.grey),
                                 contentPadding: EdgeInsets.only(top: 20),

                                 border: OutlineInputBorder(

                                     borderRadius: BorderRadius.circular(10)
                                 )
                             ),
                           ),
                         ),

                     ],
                    ),
              ),
                 
            SizedBox(height: 10,),
            Expanded(

                  child: FutureBuilder<List<TaskModel>?>(
                    future: databaseHelper.getItems(),
                    builder: (BuildContext context,AsyncSnapshot<List<TaskModel>?> snapshot){
                      if(snapshot.hasData){
                        if(!doItJustOnce){
                          list =snapshot.data!;
                          filteredList = list;
                          doItJustOnce = !doItJustOnce;

                        }
                        return ListView.builder(

                            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                            reverse: false,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredList.length,
                            itemBuilder: (BuildContext context, int index){
                              TaskModel item = filteredList[index];
                              return Dismissible(
                                  key: UniqueKey(),
                                  background: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(338, 30, 0, 0),
                                      child: Text("Delete",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),

                                    ),
                                  ),
                                  onDismissed: (direction){
                                    DatabaseHelper.delete(item);
                                  },

                                    child: TaskTile(item),
                                  );
                            });
                      }
                      return Center(child: CircularProgressIndicator(),);

                    },),
            )
          ],
        ),
      ),
    );
  }
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      
    );
  }
}
