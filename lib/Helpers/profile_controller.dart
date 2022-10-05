import 'package:get/get.dart';

class ProfileDateController extends GetxController {
  var profileStartDate = DateTime.now().obs;
  var profileEndDate = DateTime.now().obs;

  updateDateRange(DateTime start, DateTime end) {
    profileStartDate.value = start;
    profileEndDate.value = end;
  }
}
