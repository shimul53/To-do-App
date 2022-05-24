import 'package:sqflite/sqflite.dart';

import 'package:todo_app/models/taskModel.dart';

class DatabaseHelper{
  static Database? _database;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDatabase() async{
    if(_database != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'tasks.db';
      _database = await openDatabase(_path,version: _version,onCreate: (database, version){
        print("creating a new one");
        return database.execute(
          "CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title STRING, note TEXT, date STRING, "
              "startTime STRING, endTime STRING, "
              "remind INTEGER, repeat STRING, "
              "color INTEGER, "
              "isCompleted INTEGER)",
        );
      },
      );
    }catch(e){
      print(e);
    }
  }

  Future<List<TaskModel>?> getItems()async{
    var items = await _database!.query(_tableName,orderBy: 'id');
    List<TaskModel> itemList = items.isNotEmpty?items.map((e) => TaskModel.fromJson(e)).toList():[];
    return itemList;
  }
  static Future<int> insert(TaskModel? task) async{
    print("insert function called");
    return await _database?.insert(_tableName,task!.toJson())??1 ;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("query function called");
    return await _database!.query(_tableName);
  }

  static delete(TaskModel taskModel) async{
    return await  _database!.delete(_tableName,where: 'id=?',whereArgs: [taskModel.id]);
  }

  static update(int id) async{
    return await  _database!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id =?
    ''',[1,id]);
  }

  Future<int> updateData(TaskModel taskModel) async{

    return await  _database!.update(_tableName, taskModel.toJson(), where: "id=?", whereArgs: [taskModel.id]);
  }
}