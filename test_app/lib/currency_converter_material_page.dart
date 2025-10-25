import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() => _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState extends State<CurrencyConverterMaterialPage> {
  TextEditingController textEditingController = TextEditingController();
  double result = 0;
  void convert(){
    setState(() {
      result = double.parse(textEditingController.text) * 81;
      textEditingController.text = '';
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('INR $result', style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white),),
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(
              color: Colors.white
            ),
            decoration: InputDecoration(
              hintText: 'Please enter the amount in USD', 
              hintStyle: TextStyle(
                color: Colors.white60
              ),
            ),
          ),
          TextButton(onPressed: convert, style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            foregroundColor: WidgetStatePropertyAll(Colors.white)
          ),child: Text('Convert'))
        ],
      ),),
    );
  }
}