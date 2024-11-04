import 'package:flutter/material.dart';
import 'employee_list.dart';

void main() {
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
