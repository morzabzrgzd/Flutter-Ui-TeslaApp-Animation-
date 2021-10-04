import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedBottomTab = 0.obs;

  void onBottomNavigationBar(int index){
    selectedBottomTab.value = index;
    update();
  }

  RxBool isRightDoorLock = true.obs;
  RxBool isLefttDoorLock = true.obs;
  RxBool isBonnetLock = true.obs;
  RxBool isTrunkLock = true.obs;

  void updateRightDoorLock() {
    isRightDoorLock.value = !isRightDoorLock.value;
    update();
  }

   void updateLeftDoorLock() {
    isLefttDoorLock.value = !isLefttDoorLock.value;
    update();
  }

  void updateBonnetLock() {
    isBonnetLock.value = !isBonnetLock.value;
    update();
  }
  void updateTrunkLock() {
    isTrunkLock.value = !isTrunkLock.value;
    update();
  }
}
