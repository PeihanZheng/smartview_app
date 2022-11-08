import 'package:get/get.dart';

class FilterController extends GetxController {
  RxBool isHigh = RxBool(false);
  var isMedium = false.obs;
  var isLow = false.obs;

  var isAll = false.obs;
  var isIncomplete = false.obs;
  var isComplete = false.obs;

  var isTime = false;

  void onSelectedHigh(bool? value) {
    isHigh.value = value!;
  }

  // onHighSelected(value) {
  //   isHigh.value = !isHigh.value;
  // }
}
