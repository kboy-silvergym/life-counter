import 'package:objectbox/objectbox.dart';

@Entity()
class Diary {
  Diary({
    required this.title,
    required this.description,
  });

  int id = 0;
  String title;
  String description;
}
