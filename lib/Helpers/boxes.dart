import 'package:financial_ratios/Models/operation.dart';
import 'package:financial_ratios/Models/profile.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Operation> getOperations() => Hive.box<Operation>("operations");
  static Box<Profile> getProfiles() => Hive.box<Profile>("profiles");
}
