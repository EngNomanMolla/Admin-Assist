import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var userInput = ''.obs;
  var result = '0'.obs;

  void onButtonPressed(String text) {
    if (text == 'AC') {
      userInput.value = '';
      result.value = '0';
      return;
    }

    if (text == 'C') {
      if (userInput.value.isNotEmpty) {
        userInput.value = userInput.value.substring(0, userInput.value.length - 1);
      }
      return;
    }

    if (text == '=') {
      calculateResult();
      return;
    }

    // Handle leading zeros
    if (text == '0' || text == '00') {
      // If it's the very start
      if (userInput.value.isEmpty) {
        userInput.value = '0';
        return;
      }
      
      // If the current input is just '0', don't add more zeros
      if (userInput.value == '0') return;

      // If the last character is an operator, don't allow multiple leading zeros
      String lastChar = userInput.value.substring(userInput.value.length - 1);
      bool isLastOperator = ['+', '-', 'x', '÷', '%'].contains(lastChar);
      if (isLastOperator) {
        userInput.value += '0';
        return;
      }
      
      // If the current number segment is just '0'
      List<String> segments = userInput.value.split(RegExp(r'[\+\-x÷%]'));
      if (segments.isNotEmpty && segments.last == '0') return;
    }

    // Replace single '0' if a non-zero digit is pressed
    if (userInput.value == '0' && RegExp(r'[1-9]').hasMatch(text)) {
      userInput.value = text;
      return;
    }
    
    // If a digit is pressed after '0' which was following an operator
    if (userInput.value.isNotEmpty) {
      String lastChar = userInput.value.substring(userInput.value.length - 1);
      if (lastChar == '0' && RegExp(r'[1-9]').hasMatch(text)) {
        if (userInput.value.length >= 2) {
          String prevChar = userInput.value.substring(userInput.value.length - 2, userInput.value.length - 1);
          if (['+', '-', 'x', '÷', '%'].contains(prevChar)) {
            userInput.value = userInput.value.substring(0, userInput.value.length - 1) + text;
            return;
          }
        }
      }
    }

    // Handle initial state and operators
    if (userInput.value.isEmpty && (text == 'x' || text == '÷' || text == '+' || text == '-' || text == '%')) {
      if (result.value != '0' && result.value != 'Error') {
        userInput.value = result.value + text;
      }
      return;
    }

    userInput.value += text;
  }

  void calculateResult() {
    if (userInput.value.isEmpty) return;

    String finalUserInput = userInput.value;
    finalUserInput = finalUserInput.replaceAll('x', '*');
    finalUserInput = finalUserInput.replaceAll('÷', '/');
    
    // Replace % with /100. Handle cases like 10% -> 10/100
    // We need to be careful with expressions like 1000*10%
    finalUserInput = finalUserInput.replaceAll('%', '/100');

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      // Format to remove trailing .0 and limit to 2 decimal places
      String evalString = "";
      if (eval % 1 == 0) {
        evalString = eval.toInt().toString();
      } else {
        evalString = eval.toStringAsFixed(2);
        // Remove unnecessary trailing zeros after decimal point
        if (evalString.contains('.')) {
          while (evalString.endsWith('0')) {
            evalString = evalString.substring(0, evalString.length - 1);
          }
          if (evalString.endsWith('.')) {
            evalString = evalString.substring(0, evalString.length - 1);
          }
        }
      }
      
      result.value = evalString;
    } catch (e) {
      result.value = 'Error';
    }
  }
}
