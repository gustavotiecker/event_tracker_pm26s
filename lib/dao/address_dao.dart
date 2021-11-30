import 'package:event_tracker_pm26s/database/database_provider.dart';
import 'package:event_tracker_pm26s/models/address.dart';

class AddressDao {
  final databaseProvider = DatabaseProvider.instance;

  Future<bool> save(Address address) async {
    final database = await databaseProvider.database;
    final values = address.toMap();
    if (address.id == null) {
      address.id = await database.insert(Address.tableName, values);
      return true;
    } else {
      final updatedRecords = await database.update(
        Address.tableName,
        values,
        where: '${Address.fieldId} = ?',
        whereArgs: [address.id],
      );
      return updatedRecords > 0;
    }
  }

  Future<bool> remove(int id) async {
    final database = await databaseProvider.database;
    final updatedRecords = await database.delete(
      Address.tableName,
      where: '${Address.fieldId} = ?',
      whereArgs: [id],
    );
    return updatedRecords > 0;
  }

  Future<List<Address>> list() async {
    final database = await databaseProvider.database;
    final result = await database.query(
      Address.tableName,
      columns: [
        Address.fieldId,
        Address.fieldPostalCode,
        Address.fieldCountry,
        Address.fieldState,
        Address.fieldCity,
        Address.fieldStreet,
      ],
    );
    return result.map((m) => Address.fromMap(m)).toList();
  }
}
