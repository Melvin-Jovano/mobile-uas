import 'package:mobile_uas/utils/hour_check.dart';

String hourRotation(int hour, int increment) {
  int sum = hour + increment;

  if(sum > 24) {
    return '0${sum % 24}:00';
  }

  return hourCheck(sum);
}