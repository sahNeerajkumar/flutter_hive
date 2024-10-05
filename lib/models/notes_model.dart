import 'package:hive/hive.dart';
part 'notes_model.g.dart';

class NotesModel extends HiveObject {
  String title;
  String description;
  NotesModel({required this.title, required this.description});
}