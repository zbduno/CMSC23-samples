import 'package:flutter/material.dart';

class FormSample extends StatefulWidget {
  FormSample({super.key});

  @override
  _FormSampleState createState() => _FormSampleState();
}

class _FormSampleState extends State<FormSample> {
  static final List<String> _dropdownOptions = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five"
  ];

  Map<String, dynamic> formValues = {
    'searchTerm': "",
    'isChecked': false,
    'dropdownValue': _dropdownOptions.first,
};

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Column(
            children: [
              // Text Field
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter search term",
                  labelText: "Search",
                ),
                onChanged: ((String? value) {
                  formValues['searchTerm'] = value;
                }),
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              ),

              // Checkbox
              FormField(
                builder: (FormFieldState<bool> state) {
                  return Checkbox(
                    value: formValues['isChecked'],
                    onChanged: (bool? value) {
                      setState(() {
                        formValues['isChecked'] = value!;
                      });
                    },
                  );
                },
                onSaved: ((bool? value) {
                  print("Checkbox value saved!");
                }),
              ),

              // Dropdown
              FormField(
                builder: (FormFieldState<String> state) {
                  return DropdownButton<String>(
                    value: formValues['dropdownValue'],
                    onChanged: (String? value) {
                      setState(() {
                        formValues['dropdownValue'] = value!;
                      });
                    },
                    items: _dropdownOptions.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  );
                },
                onSaved: ((String? value) {
                  print("Dropdown value saved!");
                }),
              ),
              // Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            "Input Field: ${formValues['searchTerm']}\nCheckbox value: ${formValues['isChecked']}\nDropdown Value: ${formValues['dropdownValue']}",
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Text('Show text'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
