import 'package:get/get.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/taskModel.dart';


class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? task}) async{
    return await DatabaseHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DatabaseHelper.query();
    taskList.assignAll(tasks.map((data) => new TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel taskModel){
    DatabaseHelper.delete(taskModel);
    getTasks();

  }

  void markTaskCompleted( int id)async{
    await DatabaseHelper.update(id);
    getTasks();
  }
}