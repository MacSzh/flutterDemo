import 'package:flutter/material.dart';
import 'collection.dart';
import 'package:flutter_app_1/data/data_utils.dart';

class DetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  final _list = [];

  String _data = 'init';

  @override
  void initState() {
    // TODO: implement initState
    DataUtils.reserveHistory({}).then((result) {
      setState(() {
        _list.addAll(result['data']);
        _data = _list[0]['parkName'];
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(DetailPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }



  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    Widget titleSection = new Container(
//      padding: const EdgeInsets.all(32.0),
//      child: new Row(
//        children: <Widget>[
//          new Expanded(
//            child: new Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                new Container(
//                  child: new Text(
//                    'Oeschinen Lake Campground',
//                    style: new TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          new Text(
//            'Kandersteg, Switzerland',
//            style: new TextStyle(color: Colors.grey[500]),
//          ),
//          new Icon(
//            Icons.star,
//            color: Colors.red[500],
//          ),
//          new Text('41')
//        ],
//      ),
//    );

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Oeschinen Lake Campground',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'Kandersteg, Switzerland',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new FavoriteWidget()
        ],
      ),
    );

    Widget buttonSelection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, 'Call', context),
          buildButtonColumn(Icons.near_me, 'Route', context),
          buildButtonColumn(Icons.share, 'share', context)
        ],
      ),
    );

    // TODO: implement build
    return new Scaffold(
        body: getBody(titleSection, buttonSelection)
    );
  }

  getBody(titleSection,buttonSelection) {
    if (_list.length == 0) {
      return new Center(child: new CircularProgressIndicator(),);
    } else {
      return new ListView(
        children: <Widget>[
          new Image.asset(
            'images/lake.jpg',
            width: 600.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSelection,
          new Container(
            margin: EdgeInsets.all(16.0),
            child: new Text(_data),
          )
        ],
      );
  }
  }

  buildButtonColumn(IconData icon, String label, BuildContext context) {
    Color color = Theme
        .of(context)
        .primaryColor;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
