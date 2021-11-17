import 'package:event_tracker_pm26s/models/event.dart';
import 'package:flutter/material.dart';

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

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: _createBody(widget.event));
  }
}

Widget _createBody(Event event) {
  return Align(
    alignment: Alignment.center,
    child: SafeArea(
      child: Column(
        children: [
          Text(
            event.name!,
            style: titleStyle,
          ),
          Text(
            event.address!.city! + ', ' + event.address!.street!,
            style: infoStyle,
          ),
          Text(
            event.startDate!,
            style: infoStyle,
          ),
          Container(
            child: Image.network(event.imageURL!),
          ),
        ],
      ),
    ),
  );
}
