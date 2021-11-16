import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedBottomTab = 0.obs;

  void onBottomNavigationBar(int index) {
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

  RxBool isCoolSelected = true.obs;

  void updadeCoolSelectedTab() {
    isCoolSelected.value = !isCoolSelected.value;
    update();
  }

  RxInt isDegree = 29.obs;
  void increment() {
    isDegree++;
    update();
  }

  void decrement() {
    isDegree--;
    update();
  }

  RxBool isShowTyers = false.obs;
  void showTyersController(int index) {
    if (selectedBottomTab.value != 3 && index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyers.value = true;
      });
    } else {
      isShowTyers.value = false;
    }
    update();
  }

  RxBool isShowTyerStatus = false.obs;
  void tyreStatusController(int index) {
    if (selectedBottomTab.value != 3 && index == 3) {
      isShowTyerStatus.value = true;
    } else {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyerStatus.value = false;
      });
    }
    update();
  }
}
