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

    // Handle initial state and operators
    if (userInput.value.isEmpty && (text == '*' || text == '/' || text == '+' || text == '-' || text == '%')) {
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

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      // Format to remove trailing .0
      String evalString = eval.toString();
      if (evalString.endsWith('.0')) {
        evalString = evalString.substring(0, evalString.length - 2);
      }
      
      result.value = evalString;
    } catch (e) {
      result.value = 'Error';
    }
  }
}
