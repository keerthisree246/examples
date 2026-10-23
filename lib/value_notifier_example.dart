import 'package:flutter/material.dart';

class ValueNotifierExample extends StatelessWidget {
  const ValueNotifierExample({super.key});

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<int> value = ValueNotifier<int>(0);
    return Scaffold(
    appBar: AppBar(title: Text('Value Notifier'),),
    body: Center(
      child: ValueListenableBuilder<int>(
        valueListenable: value,
        builder: ((context, value, child) {
          return Text(
            'Count : $value',
            style: TextStyle(fontSize: 20),
          );
        }
        )),
    ),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          FloatingActionButton.extended(onPressed: (){
          value.value--;
        }, label: Icon(Icons.remove)),
          FloatingActionButton.extended(onPressed: (){
          value.value = 0;
        }, label: Icon(Icons.restore)),
        FloatingActionButton.extended(onPressed: (){
          value.value++;
        }, label: Icon(Icons.add)),
      
      ],
    )
    );
  }
}