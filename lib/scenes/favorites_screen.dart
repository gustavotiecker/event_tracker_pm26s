import 'package:event_tracker_pm26s/dao/event_dao.dart';
import 'package:event_tracker_pm26s/models/event.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Favoritos'),
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
                'Carregando favoritos',
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
          'Nenhum evento salvo nos favoritos',
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
          title: Text('${favorite.name}'),
          subtitle: Text(
            favorite.address?.city ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
