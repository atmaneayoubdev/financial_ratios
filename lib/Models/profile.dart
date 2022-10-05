import 'package:hive/hive.dart';
part 'profile.g.dart';

@HiveType(typeId: 1)
class Profile extends HiveObject {
  @HiveField(0)
  late DateTime startDate;

  @HiveField(1)
  late DateTime endDate;
}
