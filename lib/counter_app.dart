import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int count = 0;
  void increment(){
    setState(() {
      count++;
    });
  }
  void decrement(){
    setState(() {
      count--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('Counter App'),),
     body: Center(
      child: Text('$count',style: TextStyle(fontSize: 25),),
     ),
     floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         FloatingActionButton.extended(onPressed: ()=> decrement(), label: Icon(Icons.remove)),
         FloatingActionButton.extended(onPressed: ()=> increment(), label: Icon(Icons.add))
       ],
     ),
    );
  }
}