import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app_1/detail.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
    // TODO: implement build
    return new MaterialApp(
      title: '你好 flutter',
      home: new RandomWords(),
      debugShowCheckedModeBanner: false,
//      home: new Scaffold(
//          appBar: new AppBar(
//            title: new Text('你好'),
//          ),
//          body: new Center(
////            child: new Text('启动'),
////            child: new Text(wordPair.asPascalCase),
//            child: new RandomWords(),
//          )),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('单词生成器'),
            actions: <Widget>[
        new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        new IconButton(icon: new Icon(Icons.add,color: Colors.white,), onPressed:_goDetail)
    ],
    ),
    body: _buildSuggetions(
    )
    ,
    );
  }

  void _goDetail() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new DetailPage()));
  }

  Widget _buildSuggetions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final isSaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isSaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map(
            (pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );

      final divided =
      ListTile.divideTiles(tiles: tiles, context: context).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text('保存建议'),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }
}
