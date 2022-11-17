import 'package:flutter/material.dart';

import 'diary.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({Key? key}) : super(key: key);

  @override
  _AddDiaryPageState createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日記追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "タイトル"),
              onChanged: (String text) {
                title = text;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "詳細",
              ),
              onChanged: (String text) {
                description = text;
              },
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                final lifeEvent = Diary(title: title, description: description);
                Navigator.of(context).pop(lifeEvent);
              },
              child: Text('追加'),
            )
          ],
        ),
      ),
    );
  }
}
