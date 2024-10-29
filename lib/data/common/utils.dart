class Utils {
  static const String baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registration = '$baseUrl/Registration';
  static const String login = '$baseUrl/Login';
  static const String forgot = '$baseUrl/RecoverVerifyEmail/';
  static const String pin = '$baseUrl/RecoverVerifyOtp/';
  static const String reset = '$baseUrl/RecoverResetPassword';
  static const String addTask = '$baseUrl/createTask';
  static const String deleteTask = '$baseUrl/deleteTask/';
  static const String updateTask = '$baseUrl/updateTaskStatus/';
  static const String newTaskList = '$baseUrl/listTaskByStatus/New';
  static const String completedTaskList = '$baseUrl/listTaskByStatus/Completed';
  static const String cancelTaskList = '$baseUrl/listTaskByStatus/Cancel';
  static const String progressingTaskList =
      '$baseUrl/listTaskByStatus/Progressing';
}
//