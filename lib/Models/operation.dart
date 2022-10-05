import 'package:hive/hive.dart';
part 'operation.g.dart';

@HiveType(typeId: 0)
class Operation extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double value;

  @HiveField(2)
  late DateTime startDate;

  @HiveField(3)
  late DateTime endDate;
}
