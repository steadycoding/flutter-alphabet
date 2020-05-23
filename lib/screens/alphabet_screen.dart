
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlphabetScreen extends StatefulWidget {
  AlphabetScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AlphabetScreenState createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  // Build a list of the english alphabet
  List<String> _letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
  String _letter;
  Iterator _iterator;
  Random _randomizer;

  _AlphabetScreenState() {
    _randomizer = Random();
    _letters.shuffle(_randomizer);
    _iterator = _letters.iterator;
    _iterator.moveNext();
    _letter = _iterator.current;
  }
  // Initialize the current letter to be the first lettter in the list.

  void _changeLetter() {
    setState(() {
      if (this._iterator.moveNext()) {
        // Set the next letter
        _letter = this._iterator.current;
      } else {
        // The list has been exhausted. Start over.
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Well Done!'),
                backgroundColor: Colors.green,
                content: Text('You\'ve completed the English Alphabet. To start over press the Restart button'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Restart'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Say the sound of the following letter',
            ),
            Text(
              '$_letter',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeLetter,
        tooltip: 'Next Letter',
        child: Icon(Icons.navigate_next),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
