import 'package:get/get.dart';

class FilterController extends GetxController {
  var isHigh = false.obs;
  var isMedium = false.obs;
  var isLow = false.obs;

  var isAll = false.obs;
  var isIncomplete = false.obs;
  var isComplete = false.obs;

  var isTime = false.obs;

  onHighSelected(value) {
    isHigh.value = value;
  }

  onMediumSelected(value) {
    isMedium.value = value;
  }

  onLowSelected(value) {
    isLow.value = value;
  }

  onAllTasksSelected(value) {
    isAll.value = value;
  }

  onIncompleteSelected(value) {
    isIncomplete.value = value;
  }

  onCompleteSelected(value) {
    isComplete.value = value;
  }

  onTimeSelected(value) {
    isTime.value = value;
  }

  onPrioritySelected(value) {
    isTime.value = !value;
  }
}
