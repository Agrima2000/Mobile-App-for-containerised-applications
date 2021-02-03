import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

main() => runApp(MyHotApp());
var url, cmd;
web(cmd) async {
  url = "http://192.168.43.195/cgi-bin/web.py?x=${cmd}";
  var response = await http.get(url);
  print(response.body);
}

class MyHotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myContainer = Container(
      color: Colors.green,
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(left: 60, right: 60, top: 80, bottom: 80),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: TextField(
                autofocus: true,
                enabled: true,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    hintText: "Enter the Docker Command",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black))),
                onChanged: (value) {
                  cmd = value;
                },
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () {
                  web(cmd);
                },
                child: Text("Click Here"),
              ),
            ),
          ],
        ),
      ),
    );
    var design = MaterialApp(
      home: Scaffold(
        body: myContainer,
      ),
      debugShowCheckedModeBanner: false,
    );
    return design;
  }
}
