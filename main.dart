// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'BMI calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Units { imperial, metric }

class _MyHomePageState extends State<MyHomePage> {
  Units? _unit = Units.metric;
  final _height = TextEditingController();
  final _weight = TextEditingController();
  String _hght = '(m)';
  String _whgt = '(kg)';
  double? _bmi;

  String _message = 'Please choose units, enter your height and weight';

  void _calculate() {
    final double? height = double.tryParse(_height.value.text);
    final double? weight = double.tryParse(_weight.value.text);

    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = 'Please enter correct numbers';
      });
      return;
    }

    setState(() {
      if (_unit == Units.metric) {
        _bmi = weight / (height * height);
      } else {
        _bmi = (weight * 703) / (height * height);
      }

      if (_bmi! < 16) {
        _message = 'Starvation';
      } else if (_bmi! > 16 && _bmi! < 16.9) {
        _message = 'Emaciation';
      } else if (_bmi! > 17 && _bmi! < 18.5) {
        _message = 'Underweight';
      } else if (_bmi! > 18.5 && _bmi! < 24.9) {
        _message = 'Normal weight';
      } else if (_bmi! > 25 && _bmi! < 29.9) {
        _message = 'Overweight';
      } else if (_bmi! > 30 && _bmi! < 34.9) {
        _message = 'Obese (Class I)';
      } else if (_bmi! > 35 && _bmi! < 39.9) {
        _message = 'Obese (Class II)';
      } else {
        _message = 'Obese (Class III)';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                title: const Text('Metric'),
                leading: Radio<Units>(
                  value: Units.metric,
                  groupValue: _unit,
                  onChanged: (Units? value) {
                    setState(() {
                      _unit = value;
                      _hght = '(m)';
                      _whgt = '(kg)';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Imperial'),
                leading: Radio<Units>(
                  value: Units.imperial,
                  groupValue: _unit,
                  onChanged: (Units? value) {
                    setState(() {
                      _unit = value;
                      _hght = '(inch)';
                      _whgt = '(lbs)';
                    });
                  },
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Height ' + _hght),
                controller: _height,
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Weight ' + _whgt),
                controller: _weight,
              ),
              ElevatedButton(
                onPressed: _calculate,
                child: Text('Calculate'),
              ),
              Container(
                child: Text(
                  _bmi == null
                      ? 'Your BMI is: '
                      : 'Your BMI is: ' + _bmi!.toStringAsFixed(2),
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
