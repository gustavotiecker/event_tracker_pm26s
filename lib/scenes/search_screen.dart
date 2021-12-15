import 'package:event_tracker_pm26s/managers/network_manager.dart';
import 'package:event_tracker_pm26s/models/event.dart';
import 'package:flutter/material.dart';
import 'package:event_tracker_pm26s/utils/date_utils.dart';
import 'package:event_tracker_pm26s/utils/url_utils.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isLoading = false;
  List<Event> _events = [];
  var keywordForSearch = '';
  FloatingSearchBarController controller = new FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildFloatingSearchBar(),
          SizedBox(height: 200),
          _createList()
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      backdropColor: Colors.white,
      onSubmitted: (value) {
        setState(() {
          _isLoading = true;
        });
        NetworkManager.shared.fetchEventsBySearch(value).then((events) => {
              setState(() {
                _isLoading = false;
                _events = events;
              })
            });
      },
      textInputAction: TextInputAction.search,
      hint: 'Search...',
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        keywordForSearch = query;
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return Container();
      },
    );
  }

  Widget _createList() {
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
                'Loading events',
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

    if (_events.isEmpty) {
      return const Center(
        child: Text(
          'No results',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 80),
      child: ListView.separated(
        itemCount: _events.length,
        itemBuilder: (_, index) {
          final favorite = _events[index];
          return ListTile(
              leading: Image.network(favorite.imageURL!,
                  width: 50, height: 50, fit: BoxFit.fill),
              title: Text('${favorite.name}'),
              subtitle: Text(
                convertDate(favorite.startDate),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                launchURL(favorite.url ?? 'https://www.ticketmaster.com');
              });
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}
