import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

void main() {
  runApp(MaterialApp(
    home: MyCustomForm(),
  ));
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  final List<String> countries = ['USA', 'India'];
  final List<String> indiaProvince = [
    'New Delhi',
    'Bihar',
    'Rajasthan',
    'Kerala',
    'Karnataka'
  ];
  final List<String> usaProvince = [
    'Texas',
    'Florida',
    'California',
    'Alabama',
    'Alaska'
  ];

  List<String> provinces = [];
  String selectedCountry;
  String selectedProvince;

  void onChangedCallback(country) {
    if (country == 'USA') {
      provinces = usaProvince;
    } else if (country == 'India') {
      provinces = indiaProvince;
    } else {
      provinces = [];
    }
    setState(() {
      selectedProvince = null;
      selectedCountry = country;
    });
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registeration'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: new InputDecoration(hintText: "First Name"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (_isNumeric(value)) {
                    return 'letters are only allowed';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: new InputDecoration(hintText: "Last Name"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (_isNumeric(value)) {
                    return 'letters are only allowed';
                  }
                  return null;
                },
              ),
              Text(
                "${formatDate(selectedDate, [dd, '-', mm, '-', yyyy])}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  'Select Date of Birth',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                //color: Colors.greenAccent,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: new InputDecoration(hintText: "Address Line 1"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: new InputDecoration(hintText: "Address Line 2"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: new InputDecoration(hintText: "City"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (_isNumeric(value)) {
                    return 'letters are only allowed';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: new InputDecoration(hintText: "Post Code"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!(_isNumeric(value))) {
                    return 'Numbers are only allowed';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              DropdownButton<String>(
                isExpanded: true,
                hint: Text('Country'),
                value: selectedCountry,
                items: countries.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChangedCallback,
              ),
              SizedBox(height: 10.0),
              DropdownButton<String>(
                hint: Text('State'),
                value: selectedProvince,
                isExpanded: true,
                items: provinces.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (province) {
                  setState(() {
                    selectedProvince = province;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
