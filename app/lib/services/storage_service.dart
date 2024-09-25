import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final Logger _logger = Logger();

  static Future<String> getValue(String key) async {
    String value = '';
    await SharedPreferences.getInstance().then((instance) {
      if (instance.containsKey(key)) {
        value = instance.getString(key) ?? '';
      }
    });
    return value;
  }

  /* Storage de Notes */
  static Future<void> saveNotes(List<String> notes) async {
    await SharedPreferences.getInstance().then((instance) {
      instance.setStringList('notes', notes);
    });
  }

  static Future<List<String>> getNotes() async{
    List<String> notes = [];
    await SharedPreferences.getInstance().then((instance) {
      if (instance.containsKey('notes')) {
        notes = instance.getStringList('notes') ?? [];
      }
    });
    return notes;
  }

}
