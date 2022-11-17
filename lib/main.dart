import 'package:flutter/material.dart';

import 'add_event_page.dart';
import 'life_event.dart';
import 'objectbox.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LifeCounterPage(),
    );
  }
}

class LifeCounterPage extends StatefulWidget {
  const LifeCounterPage({Key? key}) : super(key: key);

  @override
  _LifeCounterPageState createState() => _LifeCounterPageState();
}

class _LifeCounterPageState extends State<LifeCounterPage> {
  Store? store;
  Box<LifeEvent>? lifeEventBox;
  List<LifeEvent> lifeEvents = [];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    store = await openStore();
    lifeEventBox = store?.box<LifeEvent>();
    fetchLifeEvents();
  }

  void fetchLifeEvents() {
    lifeEvents = lifeEventBox?.getAll() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('人生カウンター'),
      ),
      body: ListView.builder(
        itemCount: lifeEvents.length,
        itemBuilder: (context, index) {
          final lifeEvent = lifeEvents[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(lifeEvent.title),
                ),
                Text(
                  '${lifeEvent.count}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    lifeEvent.count--;
                    lifeEventBox?.put(lifeEvent);
                    fetchLifeEvents();
                  },
                  icon: const Icon(
                    Icons.exposure_minus_1_rounded,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      lifeEvent.count++;
                      lifeEventBox?.put(lifeEvent);
                      fetchLifeEvents();
                    },
                    icon: const Icon(
                      Icons.plus_one_rounded,
                      color: Colors.blue,
                    )),
                IconButton(
                  onPressed: () {
                    lifeEventBox?.remove(lifeEvent.id);
                    fetchLifeEvents();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ); // まずはTextを表示するだけにします。
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newLifeEvent = await Navigator.of(context).push<LifeEvent>(
            MaterialPageRoute(
              builder: (context) {
                return const AddLifeEventPage();
              },
            ),
          );
          if (newLifeEvent != null) {
            lifeEventBox?.put(newLifeEvent);
            fetchLifeEvents();
          }
        },
      ),
    );
  }
}
