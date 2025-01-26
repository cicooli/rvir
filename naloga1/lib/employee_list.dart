import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'employee.dart';
import 'employee_detail_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Employee>('employees').listenable(),
        builder: (context, Box<Employee> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No employees added yet.'),
            );
          }

          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Employee employee = box.getAt(index)!;
              return ListTile(
                title: Text('${employee.firstName} ${employee.lastName}'),
                subtitle: Text(employee.position),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailScreen(employee: employee, index: index),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEmployeeScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String position;
  late String email;

  void _addEmployee() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final box = Hive.box<Employee>('employees');
      box.add(Employee(
        firstName: firstName,
        lastName: lastName,
        position: position,
        email: email,
      ));
      Fluttertoast.showToast(msg: "Employee added successfully");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) => firstName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a first name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => lastName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a last name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Position'),
                onSaved: (value) => position = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a position' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
                validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addEmployee,
                child: Text('Add Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}