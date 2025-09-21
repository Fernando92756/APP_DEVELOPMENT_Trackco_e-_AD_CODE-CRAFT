import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Simples',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  double num1 = 0;
  double num2 = 0;
  String operation = '';
  bool shouldResetDisplay = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
        num1 = 0;
        num2 = 0;
        operation = '';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        num1 = double.parse(display);
        operation = buttonText;
        shouldResetDisplay = true;
      } else if (buttonText == '=') {
        num2 = double.parse(display);
        double result = 0;
        if (operation == '+') result = num1 + num2;
        else if (operation == '-') result = num1 - num2;
        else if (operation == '*') result = num1 * num2;
        else if (operation == '/') {
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            display = "Erro";
            return;
          }
        }
        display = result.toString();
        operation = '';
        shouldResetDisplay = true;
      } else {
        if (display == '0' || shouldResetDisplay) {
          display = buttonText;
          shouldResetDisplay = false;
        } else {
          display += buttonText;
        }
      }
    });
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(22),
          ),
          child: Text(text, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora Simples')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(display, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            children: [
              buildButton('7', Colors.grey.shade800),
              buildButton('8', Colors.grey.shade800),
              buildButton('9', Colors.grey.shade800),
              buildButton('/', Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton('4', Colors.grey.shade800),
              buildButton('5', Colors.grey.shade800),
              buildButton('6', Colors.grey.shade800),
              buildButton('*', Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton('1', Colors.grey.shade800),
              buildButton('2', Colors.grey.shade800),
              buildButton('3', Colors.grey.shade800),
              buildButton('-', Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton('0', Colors.grey.shade800),
              buildButton('C', Colors.red),
              buildButton('=', Colors.green),
              buildButton('+', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
