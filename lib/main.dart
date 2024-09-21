import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  String equation = ""; // Variable to hold the current equation
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  String openParenthesis = ""; // Track open parentheses
  String closeParenthesis = ""; // Track closed parentheses

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      equation = "";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      openParenthesis = "";
      closeParenthesis = "";
    } else if (buttonText == "(") {
      // Add open parenthesis to equation
      openParenthesis += "(";
      equation += " (";
    } else if (buttonText == ")") {
      // Add close parenthesis to equation
      closeParenthesis += ")";
      equation += " )";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/" ||
        buttonText == "%") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
      equation += " $operand "; // Update equation with operator
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "*") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      if (operand == "%") {
        _output = (num1 % num2).toString();
      }

      equation = num1.toString() +
          " " +
          operand +
          " " +
          num2.toString(); // Show the completed equation
      operand = ""; // Reset operand
    } else {
      _output = _output == "0" ? buttonText : _output + buttonText;
      if (operand.isNotEmpty) {
        equation = num1.toString() +
            " " +
            operand +
            " " +
            _output; // Update equation with second number
      } else {
        equation = _output; // Update equation with first number
      }
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(20.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          // Display the equation above the output
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          // Display the output
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Make space between output and buttons
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              // Parenthesis and Clear
              Row(
                children: <Widget>[
                  buildButton("("),
                  buildButton(")"),
                  buildButton("C"),
                  buildButton("/"),
                ],
              ),
              // Numbers and Multiply
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("*"),
                ],
              ),
              // Numbers and Subtract
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-"),
                ],
              ),
              // Numbers and Add
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+"),
                ],
              ),
              // Decimal, Zero, Double Zero, and Equals
              Row(
                children: <Widget>[
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
