import 'package:flutter/material.dart';
import 'package:naloga1/employee.dart';
import 'employee_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox<Employee>('employees');
  runApp(EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: EmployeeListScreen(),
    );
  }
}
