import 'package:event_tracker_pm26s/database/database_provider.dart';
import 'package:event_tracker_pm26s/models/event.dart';
import 'package:sqflite/sqflite.dart';

class EventDao {
  final databaseProvider = DatabaseProvider.instance;

  Future<bool> save(Event event) async {
    final database = await databaseProvider.database;

    await database.insert(
      Event.tableName,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return true;
  }

  Future<bool> remove(String id) async {
    final database = await databaseProvider.database;
    final updatedRecords = await database.delete(
      Event.tableName,
      where: '${Event.fieldId} = ?',
      whereArgs: [id],
    );
    return updatedRecords > 0;
  }

  Future<List<Event>> list() async {
    final database = await databaseProvider.database;
    final result = await database.query(
      Event.tableName,
      columns: [
        Event.fieldId,
        Event.fieldName,
        Event.fieldDescription,
        Event.fieldType,
        Event.fieldTicketPrice,
        Event.fieldLongitude,
        Event.fieldLatitude,
        Event.fieldUrl,
        Event.fieldStartDate,
        Event.fieldImageURL,
      ],
    );
    return result.map((m) => Event.fromMap(m)).toList();
  }
}
