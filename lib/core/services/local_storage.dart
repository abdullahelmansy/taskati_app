import 'package:hive_flutter/hive_flutter.dart';

import '../model/task_model.dart';

class AppLocalStorage {
  static String kIsUploaded = 'isUpload';
  static String kUserName = 'name';
  static String kUserImage = 'image';
  static String kIsDarkMode = 'isDarkMode';

  static late Box userBox;
  static late Box<TaskModel> taskBox;

  static init() {
    userBox = Hive.box('userBox');
    taskBox = Hive.box('TaskBox');
  }

  static cacheData(String key, value) {
    userBox.put(key, value);
  }

  static getCachedData(String key) {
    return userBox.get(key);
  }

  static cacheTask(String key, TaskModel value) {
    taskBox.put(key, value);
  }

  static TaskModel? getCachedTask(String key) {
    return taskBox.get(key);
  }
}
