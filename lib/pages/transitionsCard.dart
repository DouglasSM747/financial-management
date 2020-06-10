import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TransitionsPage extends StatefulWidget {
  @override
  _TransitionsPageState createState() => _TransitionsPageState();
}

final atualMonth = DateTime.now().month;
final _popItem = <String>["Share", "View chart"];
List<PopupMenuItem<String>> pop = _popItem
    .map((String val) => PopupMenuItem<String>(
          value: val,
          child: Text(val),
        ))
    .toList();

popUpNavigator(String value) {
  print(value);
}

List<String> dateformat(int monthAtual) {
  DateTime tm = new DateTime.now();
  String month;
  switch (monthAtual) {
    case 1:
      month = "JANUARY";
      break;
    case 2:
      month = "FEBRUARAY";
      break;
    case 3:
      month = "MARCH";
      break;
    case 4:
      month = "APRIL";
      break;
    case 5:
      month = "MAY";
      break;
    case 6:
      month = "JUNE";
      break;
    case 7:
      month = "JULY";
      break;
    case 8:
      month = "AUGUST";
      break;
    case 9:
      month = "SEPTEMBER";
      break;
    case 10:
      month = "OCTOBER";
      break;
    case 11:
      month = "NOVEMBER";
      break;
    case 12:
      month = "DECEMBER";
      break;
  }

  return [tm.day.toString(), month, tm.year.toString()];
}

class _TransitionsPageState extends State<TransitionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(child: Text("Monthly Expenses/gain")),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: popUpNavigator,
            itemBuilder: (BuildContext context) {
              return pop;
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            itemCount: 12,
            itemBuilder: (BuildContext context, int itemIndex) {
              return cardMounth(itemIndex);
            },
            options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 1.1,
              initialPage: atualMonth - 1,
              height: MediaQuery.of(context).size.height - 120,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                setState(
                  () {
                    // _current = index;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget cardMounth(int index) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: _width - 20,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  dateformat(index + 1)[1],
                  style: TextStyle(color: Colors.black, fontSize: 30),
                )
              ],
            ),
          ),
          Text(dateformat(index + 1)[1])
        ],
      ),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
