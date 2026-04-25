import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/controller/calculator_controller.dart';

class CalculatorScreen extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF3F4F6),
      ),
      child: Column(
        children: [
          // Display Section
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() => Text(
                        controller.userInput.value,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.black54,
                          fontFamily: 'Inter',
                        ),
                      )),
                  const SizedBox(height: 10),
                  Obx(() => Text(
                        controller.result.value,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: 'Inter',
                        ),
                      )),
                ],
              ),
            ),
          ),
          
          // Buttons Section
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButtonRow(['AC', 'C', '%', '÷'], [Colors.redAccent, Colors.orangeAccent, const Color(0xFF7B61FF), const Color(0xFF7B61FF)]),
                  _buildButtonRow(['7', '8', '9', 'x'], [Colors.black87, Colors.black87, Colors.black87, const Color(0xFF7B61FF)]),
                  _buildButtonRow(['4', '5', '6', '-'], [Colors.black87, Colors.black87, Colors.black87, const Color(0xFF7B61FF)]),
                  _buildButtonRow(['1', '2', '3', '+'], [Colors.black87, Colors.black87, Colors.black87, const Color(0xFF7B61FF)]),
                  _buildButtonRow(['0', '.', '=', ''], [Colors.black87, Colors.black87, Colors.green, Colors.transparent]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> labels, List<Color> colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        if (labels[index].isEmpty) {
          return const SizedBox(width: 70, height: 70); // Empty space
        }
        return _buildButton(labels[index], colors[index]);
      }),
    );
  }

  Widget _buildButton(String text, Color textColor) {
    bool isOperator = ['÷', 'x', '-', '+', '=', '%'].contains(text);
    bool isClear = ['AC', 'C'].contains(text);
    
    Color bgColor = isOperator ? textColor.withOpacity(0.1) : Colors.grey.shade50;
    if (text == '=') {
      bgColor = textColor; // Green background for equals
      textColor = Colors.white;
    } else if (isClear) {
      bgColor = textColor.withOpacity(0.1);
    }

    return GestureDetector(
      onTap: () => controller.onButtonPressed(text),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            if (!isOperator && !isClear && text != '=')
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: text == 'AC' ? 20 : 28,
              fontWeight: FontWeight.w600,
              color: textColor,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}
