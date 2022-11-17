import 'package:flutter/material.dart';
import 'package:life_counter/diary/diary.dart';

import '../objectbox.g.dart';
import 'add_diary_page.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  _DiaryPagePageState createState() => _DiaryPagePageState();
}

class _DiaryPagePageState extends State<DiaryPage> {
  Store? store;
  Box<Diary>? diaryBox;
  List<Diary> diaries = [];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    store = await openStore();
    diaryBox = store?.box<Diary>();
    fetchDiary();
  }

  void fetchDiary() {
    diaries = diaryBox?.getAll() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日記'),
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("全部削除してもよろしいですか？"),
                        actions: <Widget>[
                          // ボタン領域
                          TextButton(
                            child: Text("いいえ"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text("はい"),
                            onPressed: () {
                              diaryBox?.removeAll();
                              fetchDiary();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Text(
                '全削除',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: diaries.length,
        itemBuilder: (context, index) {
          final diary = diaries[index];
          return ListTile(
            title: Text(diary.title),
            subtitle: Text(diary.description),
          ); // まずはTextを表示するだけにします。
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newDiary = await Navigator.of(context).push<Diary>(
            MaterialPageRoute(
              builder: (context) {
                return const AddDiaryPage();
              },
            ),
          );
          if (newDiary != null) {
            diaryBox?.put(newDiary);
            fetchDiary();
          }
        },
      ),
    );
  }
}
