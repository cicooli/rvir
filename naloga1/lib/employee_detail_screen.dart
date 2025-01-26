import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'employee.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Employee employee;
  final int index;

  EmployeeDetailScreen({required this.employee, required this.index});

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String position;
  late String email;

  @override
  void initState() {
    super.initState();
    firstName = widget.employee.firstName;
    lastName = widget.employee.lastName;
    position = widget.employee.position;
    email = widget.employee.email;
  }

  void _updateEmployee() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final box = Hive.box<Employee>('employees');
      box.putAt(
        widget.index,
        Employee(
          firstName: firstName,
          lastName: lastName,
          position: position,
          email: email,
        ),
      );
      Fluttertoast.showToast(msg: "Employee updated successfully");
      Navigator.pop(context);
    }
  }

  void _deleteEmployee() {
    final box = Hive.box<Employee>('employees');
    box.deleteAt(widget.index);
    Fluttertoast.showToast(msg: "Employee deleted successfully");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteEmployee,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: firstName,
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) => firstName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a first name' : null,
              ),
              TextFormField(
                initialValue: lastName,
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => lastName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a last name' : null,
              ),
              TextFormField(
                initialValue: position,
                decoration: InputDecoration(labelText: 'Position'),
                onSaved: (value) => position = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a position' : null,
              ),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
                validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateEmployee,
                child: Text('Update Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}