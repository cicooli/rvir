import 'package:hive/hive.dart';
part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String position;
  @HiveField(3)
  String email;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.email,
  });
}
