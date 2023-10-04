import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shishir_calculator/colors.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

// Variables

double firstNum = 0.0;
double secondNum = 0.0;
var input = '';
var output = '';
var operation = '';
var hideInput = false;
var outputSize = 30.0;

onButtonClick(value){

  // if value is AC
  if (value=="AC") {
     input = '';
     output = '';
  }

  else if(value=="DEL"){
    if(input.isNotEmpty){
    input=input.substring(0,input.length-1);
    }
  }
  else if(value=="="){
    if(input.isNotEmpty){
    var userInput = input;
    userInput= input.replaceAll("x", "*");
    Parser p = Parser();
    Expression expression = p.parse(userInput);
    ContextModel cm = ContextModel();
    var finalValue = expression.evaluate(EvaluationType.REAL, cm);
    output = finalValue.toString();
     if(output.endsWith(".0")){
      output= output.substring(0,output.length-2);
     }
     input = output;
     hideInput = true;
    outputSize = 70;
    }
  }
  else{
    input = input + value;
    hideInput = false;
    outputSize = 30;
  }
 setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Input Output Area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                  hideInput ? '':  input,
                    style:const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 25,),
                ],
              ),
            ),
          ),
          // Buttons Area
          Row(
            children: [
              button(
                  text: "AC",
                  tcolor: orangeColor,
                  buttonBgcolor: operatorColor),
              button(
                  text: "DEL", tcolor: orangeColor, buttonBgcolor: operatorColor),
              button(text: "",buttonBgcolor: Colors.transparent ),
              button(
                  text: "/", tcolor: orangeColor, buttonBgcolor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x", tcolor: orangeColor, buttonBgcolor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", tcolor: orangeColor, buttonBgcolor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", tcolor: orangeColor, buttonBgcolor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", tcolor: orangeColor, buttonBgcolor: operatorColor),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonBgcolor: orangeColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tcolor = Colors.white, buttonBgcolor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ), backgroundColor: buttonBgcolor,
              padding: const EdgeInsets.all(12)),
          onPressed: ()=>onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: tcolor),
          ),
        ),
      ),
    );
  }
}
