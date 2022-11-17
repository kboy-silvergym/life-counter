import 'package:flutter/material.dart';
import 'package:life_counter/life_counter/life_event.dart';

class AddLifeEventPage extends StatefulWidget {
  const AddLifeEventPage({Key? key}) : super(key: key);

  @override
  _AddLifeEventPageState createState() => _AddLifeEventPageState();
}

class _AddLifeEventPageState extends State<AddLifeEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ライフイベント追加'),
      ),
      body: TextFormField(
        onFieldSubmitted: (String text) {
          final lifeEvent = LifeEvent(title: text, count: 0);
          Navigator.of(context).pop(lifeEvent);
        },
      ),
    );
  }
}
