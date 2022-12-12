import 'package:flutter/material.dart';
import 'calculator_button.dart';
import 'result_display.dart';
import 'calculation.dart';
import 'dart:math';

class SciCalculation extends StatefulWidget {
  const SciCalculation({super.key});

  @override
  State<SciCalculation> createState() => _SciCalculationState();
}

class _SciCalculationState extends State<SciCalculation> {
  double width = 0;
  int? firstOperand;
  String? operator;
  int? secondOperand;
  double? result;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          ResultDisplay(text: _getDisplayText()),
          Row(
            children: const [Padding(padding: EdgeInsets.all(16.0))],
          ),
          Row(
            children: [
              _getButton(
                  text: '√',
                  onTap: () => operatorPressed('√'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
              _getButton(
                  text: ' x²',
                  onTap: () => operatorPressed('²'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
              _getButton(
                  text: ' x³',
                  onTap: () => operatorPressed('³'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
              _getButton(
                  text: 'log',
                  onTap: () => operatorPressed('log'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
            ],
          ),
          Row(
            children: [
              _getButton(
                  text: '⛶',
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Calculation()));
                  },
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
              _getButton(
                  text: 'sin',
                  onTap: () => operatorPressed('sin'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
              _getButton(
                  text: 'cos',
                  onTap: () => operatorPressed('cos'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
              _getButton(
                  text: 'tan',
                  onTap: () => operatorPressed('tan'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
            ],
          ),
          Row(
            children: [
              _getButton(text: '7', onTap: () => numberPressed(7)),
              _getButton(text: '8', onTap: () => numberPressed(8)),
              _getButton(text: '9', onTap: () => numberPressed(9)),
              _getButton(
                  text: '-',
                  onTap: () => operatorPressed('-'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
            ],
          ),
          Row(
            children: [
              _getButton(text: '4', onTap: () => numberPressed(4)),
              _getButton(text: '5', onTap: () => numberPressed(5)),
              _getButton(text: '6', onTap: () => numberPressed(6)),
              _getButton(
                  text: '÷',
                  onTap: () => operatorPressed('÷'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
            ],
          ),
          Row(
            children: [
              _getButton(text: '1', onTap: () => numberPressed(1)),
              _getButton(text: '2', onTap: () => numberPressed(2)),
              _getButton(text: '3', onTap: () => numberPressed(3)),
              _getButton(
                  text: '+',
                  onTap: () => operatorPressed('+'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black)
            ],
          ),
          Row(
            children: [
              _getButton(
                  text: 'C',
                  onTap: clear,
                  backgroundColor: Color.fromARGB(255, 205, 43, 43),
                  textColor: Colors.white),
              _getButton(text: '0', onTap: () => numberPressed(0)),
              _getButton(
                  text: '=',
                  onTap: calculateResult,
                  backgroundColor: Colors.orange,
                  textColor: Colors.white),
              _getButton(
                  text: '×',
                  onTap: () => operatorPressed('*'),
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  textColor: Colors.black),
            ],
          ),
          Row(
            children: const [Padding(padding: EdgeInsets.all(16.0))],
          ),
        ]));
  }

  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  numberPressed(int number) {
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }
      secondOperand = int.parse('$secondOperand$number');
    });
  }

  calculateResult() {
    if (operator == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case 'sin':
          result = sin(firstOperand!.toDouble());
          break;
        case 'cos':
          result = cos(firstOperand!.toDouble());
          break;
        case 'tan':
          result = tan(firstOperand!.toDouble());
          break;
        case 'log':
          if (secondOperand == null) {
            return;
          }
          result = log(secondOperand!.toDouble());
          break;
        case '√':
          if (secondOperand == null) {
            return;
          }
          result = sqrt(secondOperand!.toDouble());
          break;
        case '²':
          result = (pow(firstOperand!, 2)).toDouble();
          break;
        case '³':
          result = (pow(firstOperand!, 3)).toDouble();
          break;
        case '+':
          if (secondOperand == null) {
            return;
          }
          result = firstOperand!.toDouble() + secondOperand!.toDouble();
          break;
        case '-':
          if (secondOperand == null) {
            return;
          }
          result = firstOperand!.toDouble() - secondOperand!.toDouble();
          break;
        case '*':
          if (secondOperand == null) {
            return;
          }
          result = firstOperand!.toDouble() * secondOperand!.toDouble();
          break;
        case '÷':
          if (secondOperand == 0 || secondOperand == null) {
            return;
          }
          result = (firstOperand!.toDouble() / secondOperand!.toDouble());
          break;
      }
      firstOperand = result!.round();
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }

    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }

  Widget _getButton({
    required String text,
    required VoidCallback onTap,
    Color backgroundColor = const Color.fromARGB(255, 72, 72, 72),
    Color textColor = const Color.fromARGB(255, 255, 255, 255),
  }) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }
}
