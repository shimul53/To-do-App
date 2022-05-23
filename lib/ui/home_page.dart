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
import 'package:todo_app/controllers/task_conntroller.dart';
import 'package:todo_app/models/taskModel.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/add_task_bar.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _taskController.getTasks();


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
            _bottomSheetButton(label: "Update", onTap: (){Get.to(()=>UpdatePage( )); }, color:Color(0xFF66BB6A)!,context:context ),
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
        Icon(Get.isDarkMode? Icons.search : Icons.search,size: 25,color: Get.isDarkMode? Colors.white:Colors.black,),
        SizedBox(width: 20,)
      ],
    );
  }
}
