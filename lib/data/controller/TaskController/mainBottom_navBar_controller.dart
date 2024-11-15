import 'package:get/get.dart';

class MainBottomNavBarController extends GetxController {
  var selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }
}
//