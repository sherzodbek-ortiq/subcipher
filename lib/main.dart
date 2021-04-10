import 'package:flutter/material.dart';

import './utils/services/local_storage_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subcipher',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue[700],
          accentColor: Colors.blue[800],
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              )),
      home: MyHomePage(title: 'Subcipher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title = ""});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _charsController = TextEditingController();
  String _counter = '';

  Future<void> _incrementCounter() async {
    final enteredChars = _charsController.text;
    LocalStorageService().writeChars("chars.txt", enteredChars);
    final String fileContent =
        await LocalStorageService().readChars("chars.txt");
    setState(() {
      _counter = fileContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Enter chars for encryption key',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Chars',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                controller: _charsController,
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[800],
                  ),
                ),
                ElevatedButton(
                  child: Text('Generate key'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[800],
                  ),
                ),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
