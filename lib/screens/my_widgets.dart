import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextFormField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: TextFormField(
            controller: TextEditingController(),

            maxLines:
                9, // Устанавливаем максимальное количество строк равным null
            decoration: const InputDecoration(
                hintText: 'Введите текст',
                floatingLabelAlignment: FloatingLabelAlignment.center,
                border: OutlineInputBorder()),
          ),
        ),
      ),
    );
  }
}
