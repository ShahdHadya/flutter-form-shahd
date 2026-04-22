import 'package:flutter/material.dart';
import 'OutputScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyFormScreen(),
        '/output': (context) => const OutputScreen(),
      },
    );
  }
}

class MyFormScreen extends StatefulWidget {
  const MyFormScreen({super.key});

  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;
  String? _email;
  bool _rememberMe = false;
  String? _gender;
  String? _country;
  double _age = 18;
  DateTime? _selectedDate;

  final List<String> _countries = [
    'Palestine',
    'Jordan',
    'Egypt',
    'Syria',
    'Iraq',
  ];

  final List<String> _genders = ['Male', 'Female'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pushNamed(
        context,
        '/output',
        arguments: {
          'username': _username,
          'password': _password,
          'email': _email,
          'rememberMe': _rememberMe,
          'gender': _gender,
          'country': _country,
          'age': _age,
          'selectedDate': _selectedDate,
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Form Demo, Done By Shahd')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Username
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter username' : null,
                onSaved: (value) => _username = value,
              ),

              const SizedBox(height: 16),

              /// Password
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter password';
                  if (value.length < 6) return 'Min 6 chars';
                  return null;
                },
                onSaved: (value) => _password = value,
              ),

              const SizedBox(height: 16),

              /// Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter email';
                  if (!value.contains('@')) return 'Invalid email';
                  return null;
                },
                onSaved: (value) => _email = value,
              ),

              const SizedBox(height: 16),

              /// Checkbox
              CheckboxListTile(
                title: const Text('Remember me'),
                value: _rememberMe,
                onChanged: (value) {
                  setState(() => _rememberMe = value!);
                },
              ),

              /// Gender
              Row(
                children: [
                  const Text('Gender: '),
                  ..._genders.map(
                    (g) => Row(
                      children: [
                        Radio<String>(
                          value: g.toLowerCase(),
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() => _gender = value);
                          },
                        ),
                        Text(g),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Country
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                items:
                    _countries
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                onChanged: (value) => _country = value,
                validator: (value) => value == null ? 'Select country' : null,
                onSaved: (value) => _country = value,
              ),

              const SizedBox(height: 16),

              /// Age Slider
              Row(
                children: [
                  const Text('Age:'),
                  Expanded(
                    child: Slider(
                      value: _age,
                      min: 18,
                      max: 99,
                      divisions: 81,
                      label: _age.round().toString(),
                      onChanged: (value) {
                        setState(() => _age = value);
                      },
                    ),
                  ),
                  Text(_age.round().toString()),
                ],
              ),

              const SizedBox(height: 16),

              /// Date Picker
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Submit
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
