import 'package:event_tracker_pm26s/dao/event_dao.dart';
import 'package:event_tracker_pm26s/database/database_provider.dart';
import 'package:event_tracker_pm26s/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const titleStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 20,
  height: 1,
);

const infoStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

const infoText = TextStyle(
    color: Color.fromRGBO(100, 100, 100, 1.0),
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5);

const bodyText = TextStyle(
    color: Color.fromRGBO(80, 80, 80, 1.0),
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5);

final double padding = 25;
final double spacing = 18;
final sidePadding = EdgeInsets.symmetric(horizontal: padding);
var _isFavorite = false;

final _eventDao = EventDao();

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  void initState() {
    super.initState();
    _modifyFavorite(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: _createBody(widget.event, context));
  }

  Widget _createBody(Event event, BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(event.imageURL!,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 4,
                              fit: BoxFit.fill),
                          Positioned(
                            width: MediaQuery.of(context).size.width,
                            top: padding,
                            child: Padding(
                              padding: sidePadding,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                        141, 141, 141, 1.0)
                                                    .withAlpha(40),
                                                width: 2)),
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Icon(
                                                Icons.keyboard_backspace,
                                                color: Colors.blue))),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _eventDao.save(event).then(
                                            (value) => _modifyFavorite(event));
                                      },
                                      child: _createFavoriteIcon())
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(spacing),
                      Padding(
                        padding: sidePadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 300,
                                    child: Text(
                                      event.name ?? '',
                                      style: titleStyle,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(spacing),
                      Padding(
                          padding: sidePadding,
                          child: Row(
                            children: [
                              IconTheme(
                                data: IconThemeData(color: Colors.grey),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              addHorizontalSpace(spacing),
                              Text(
                                  (event.address?.city ?? '') +
                                      (', ') +
                                      (event.address?.street ?? ''),
                                  style: infoText),
                            ],
                          )),
                      addVerticalSpace(spacing),
                      Padding(
                          padding: sidePadding,
                          child: Row(
                            children: [
                              IconTheme(
                                data: IconThemeData(color: Colors.grey),
                                child: Icon(Icons.calendar_today_outlined),
                              ),
                              addHorizontalSpace(spacing),
                              Text(convertDate(event.startDate ?? ''),
                                  style: infoText),
                            ],
                          )),
                      addVerticalSpace(spacing),
                      Padding(
                        padding: sidePadding,
                        child: Text(
                            event.description ??
                                'This event does not have a description.',
                            textAlign: TextAlign.justify,
                            style: bodyText),
                      ),
                      addVerticalSpace(spacing * 3),
                      Padding(
                        padding: sidePadding,
                        child: Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.all(15),
                                onSurface: Colors.grey,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: Text('Ver no TicketMaster'),
                              onPressed: () {
                                _launchURL(event.url ??
                                    'https://www.ticketmaster.com');
                              }),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _modifyFavorite(Event event) async {
    setState(() {
      _eventDao.list().then((events) => {
            events.forEach((eventFounded) {
              if (event.id == eventFounded.id) {
                _isFavorite = true;
              } else {
                _isFavorite = false;
              }
            })
          });
    });
  }
}

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

String convertDate(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

_launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

Container _createFavoriteIcon() {
  if (_isFavorite) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Icon(Icons.favorite, color: Colors.red)));
  } else {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(
                color: Color.fromRGBO(141, 141, 141, 1.0).withAlpha(40),
                width: 2)),
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Icon(Icons.favorite_border, color: Colors.blue)));
  }
}
