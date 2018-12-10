import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primaryColor: Colors.yellow),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final words = <WordPair>[];
  final Set<WordPair> saved = new Set<WordPair>();

  final font = TextStyle(
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return Divider();
      words.addAll(generateWordPairs().take(10));
      return buildRow(words[i]);
    });
  }

  Widget buildRow(WordPair pair) {
    final bool alreadySaved = saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: font),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = getTiles(saved);
      final List<Widget> divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return new Scaffold(
          appBar: AppBar(title: Text('Saved Suggestions')),
          body: ListView(children: divided));
    }));
  }

  Iterable<ListTile> getTiles(Set<WordPair> saved) {
    return saved.map((WordPair wordPair) {
      return new ListTile(
        title: Text(wordPair.asPascalCase, style: font),
      );
    });
  }
}

class RandomWords extends StatefulWidget {
  @override
  State createState() {
    return RandomWordsState();
  }
}
