import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/controllers/task_conntroller.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/taskModel.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/add_task_bar.dart';
import 'package:todo_app/ui/search_page.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/update_page.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:todo_app/ui/widgets/task_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  final _taskController = Get.put(TaskController());

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  TextEditingController remindController = TextEditingController();

  List<TaskModel> datas = [];
  bool fetching = true;
  int currentIndex = 0;

 late DatabaseHelper db;
  late final int index;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _taskController.getTasks();
    db = DatabaseHelper();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(height: 20),
          _showTask(),
        ],
      ),
    );
  }
  _showTask(){
    return Expanded(
        child: Obx((){

          return ListView.builder(

              itemCount: _taskController.taskList.length,
              itemBuilder: (_, index){

                TaskModel taskModel = _taskController.taskList[index];
                //print(taskModel.toJson());

                if(taskModel.date == DateFormat.yMd().format(_selectedDate)){
                  return AnimationConfiguration.staggeredList(

                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  _showBottomSheet(context,taskModel,);

                                },
                                child: TaskTile(taskModel),
                              ),
                            ],
                          ),
                        ),
                      )
                  );
                }else{
                  return Container();
                }



              }) ;
        })

    );
  }

  _showBottomSheet(BuildContext context,TaskModel task){

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1? MediaQuery.of(context).size.height*0.26 :MediaQuery.of(context).size.height*0.32,
        color: Get.isDarkMode?darkGreyClr:Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode? Colors.grey[600]:Colors.grey[300]
              ),
            ),
            Spacer(),
            task.isCompleted ==1?Container():_bottomSheetButton(label: "Task Completed", onTap: (){_taskController.markTaskCompleted(task.id!); Get.back();}, color:primaryClr,context:context ),
            SizedBox(height: 10,),
            _bottomSheetButton(label: "Update", onTap: (){updateDialogue(task); }, color:Color(0xFF66BB6A)!,context:context ),
            SizedBox(height: 10,),
            _bottomSheetButton(label: "Delete Task", onTap: (){_taskController.delete(task); Get.back();}, color:Colors.red[300]!,context:context ),
            SizedBox(height: 10,),
            _bottomSheetButton(label: "Close", onTap: (){ Get.back();}, color:Colors.red[300]!,isClose: true,context:context ),
            SizedBox(height: 10,),
          ],
        ),
      ),

    );
  }

  _bottomSheetButton({required String label,required Function() onTap,required Color color,bool isClose = false,required BuildContext context}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose == true?Get.isDarkMode?Colors.grey[600]! : Colors.grey[300]! : color
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClose == true?Colors.transparent : color
        ),
        child: Center(
          child: Text(
            label,style: isClose? titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),

      ),
    );
  }
  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate:  DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate = date;
          });
        },

      ),
    );
  }
  _addTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),style: subHeadingStyle,),
                Text("Today",style: headingStyle,),
              ],
            ),
          ),
          Button(label: "+ Add Task", onTap: () async{
            await Get.to( () => AddTaskPage());

            _taskController.getTasks();
          }),
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
        GestureDetector(onTap:(){
          Get.to(()=> SearchPage());
        },child: Icon(Get.isDarkMode? Icons.search : Icons.search,size: 25,color: Get.isDarkMode? Colors.white:Colors.black,)),
        SizedBox(width: 20,)
      ],
    );
  }


  void updateDialogue(TaskModel task) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(14),
            content: Container(
              height: 430,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: "Title"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(labelText: "Description"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(labelText: "Date"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: startTimeController ,
                      decoration: InputDecoration(labelText: "Time"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: endTimeController ,
                      decoration: InputDecoration(labelText: "Time"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: remindController,
                      decoration: InputDecoration(labelText: "Remind"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: repeatController,
                      decoration: InputDecoration(labelText: "Repeat"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  TaskModel taskModel = datas[currentIndex];
                  taskModel.title = noteController.text;
                  taskModel.note = titleController.text;
                  taskModel.date=dateController.text;
                  taskModel.startTime=startTimeController.text;
                  taskModel.endTime=endTimeController.text;
                  taskModel.repeat= repeatController.text;
                  taskModel.remind=remindController.text as int? ;
                  db.updateData(taskModel);
                  setState(() {});
                  Navigator.pop(context);
                },

                child: Text("Update"),
              ),
            ],
          );
        });
  }
  void edit(index) {
    currentIndex = index;
    titleController.text = datas[index].title!;
    noteController.text = datas[index].note!;
    dateController.text = datas[index].date!;
    startTimeController.text=datas[index].startTime!;
    endTimeController.text=datas[index].endTime!;
    repeatController.text=datas[index].repeat!;
    remindController.text =datas[index].remind! as String ;
    updateDialogue(index);
  }
}
