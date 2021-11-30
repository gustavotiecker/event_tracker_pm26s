import 'package:event_tracker_pm26s/database/database_provider.dart';
import 'package:event_tracker_pm26s/models/event.dart';

class EventDao{
  final databaseProvider = DatabaseProvider.instance;

  Future<bool> save(Event event) async {
    final database = await databaseProvider.database;
    final values = event.toMap();
    if (event.id == null) {
      event.id = await database.insert(Event.tableName, values).toString();
      return true;
    } else {
      final updatedRecords = await database.update(
        Event.tableName,
        values,
        where: '${Event.fieldId} = ?',
        whereArgs: [event.id],
      );
      return updatedRecords > 0;
    }
  }

  Future<bool> remove(int id) async {
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
        Event.fieldAddressId,
        Event.fieldUrl,
        Event.fieldStartDate,
        Event.fieldImageURL,
      ],
    );
    return result.map((m) => Event.fromMap(m)).toList();
  }
}