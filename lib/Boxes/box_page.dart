import 'package:flutter_hive/models/notes_model.dart';
import 'package:hive/hive.dart';

class BoxPage{
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}