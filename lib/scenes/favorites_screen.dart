import 'package:event_tracker_pm26s/dao/event_dao.dart';
import 'package:event_tracker_pm26s/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _favorites = <Event>[];
  var _isLoading = false;
  final _eventDao = EventDao();

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Loading favorites',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (_favorites.isEmpty) {
      return const Center(
        child: Text(
          'No favorite events saved',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: _favorites.length,
      itemBuilder: (_, index) {
        final favorite = _favorites[index];
        return ListTile(
          leading: Image.network(favorite.imageURL!,
              width: 50, height: 50, fit: BoxFit.fill),
          title: Text('${favorite.name}'),
          subtitle: Text(
            convertDate(favorite.startDate),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: InkWell(
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(
                          color:
                              Color.fromRGBO(141, 141, 141, 1.0).withAlpha(40),
                          width: 2)),
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child:
                          Icon(Icons.restore_from_trash, color: Colors.red))),
              onTap: () {
                setState(() {
                  _eventDao.remove(favorite.id).then((value) => _updateList());
                });
              }),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }

  Future<void> _updateList() async {
    setState(() {
      _isLoading = true;
    });
    final favoritos = await _eventDao.list();
    setState(() {
      _isLoading = false;
      _favorites.clear();
      if (favoritos.isNotEmpty) {
        _favorites.addAll(favoritos);
        print(_favorites);
      }
      print(_favorites);
    });
  }
}

String convertDate(String? date) {
  if (date != null) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
  return '';
}
