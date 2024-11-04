import 'package:flutter/material.dart';
import 'employee.dart';
import 'add_employee.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> employees = [];

  void _addEmployee(Employee employee) {
    setState(() {
      employees.add(employee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: employees.isEmpty
          ? Center(child: Text('No employees added'))
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text('${employee.firstName} ${employee.lastName}'),
                  subtitle: Text('${employee.position} - ${employee.email}'),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Employee'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEmployeeScreen(onAddEmployee: _addEmployee),
              ),
            );
          }
        },
      ),
    );
  }
}
