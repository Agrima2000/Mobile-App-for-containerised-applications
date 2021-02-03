import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

main() => runApp(MaterialApp(
      home: DockerApp(),
    ));

class DockerApp extends StatefulWidget {
  @override
  _DockerAppState createState() => _DockerAppState();
}

class _DockerAppState extends State<DockerApp> {
  var url, cmd, webdata;
  var index = 0;
  var db = ['date', 'cal'];
  web(cmd) async {
    url = "http://192.168.43.195/cgi-bin/web.py?x=${cmd}";
    var response = await http.get(url);

    setState(() {
      index = index + 1;
      webdata = response.body;
      print(webdata);
    });
  }

  @override
  Widget build(BuildContext context) {
    var myScaffold = Scaffold(
      appBar: AppBar(
        title: Text("LW"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(db[index % db.length]),
            Card(
              child: FlatButton(
                onPressed: () {
                  web(db[index % db.length]);
                },
                child: Text("Let command to execute"),
              ),
            ),
            Text(webdata ?? "Click Here"),
          ],
        ),
      ),
    );
    return myScaffold;
  }
}
