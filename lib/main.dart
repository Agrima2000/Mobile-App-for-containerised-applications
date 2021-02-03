import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';
import 'package:giphy_picker/giphy_picker.dart';

main() => runApp(MaterialApp(
      home: DockerApp(),
      debugShowCheckedModeBanner: false,
    ));

class DockerApp extends StatefulWidget {
  @override
  _DockerAppState createState() => _DockerAppState();
}

class _DockerAppState extends State<DockerApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new MainPage(),
      image: Image.asset(
        "assets/docker.jpeg",
        width: 300,
        height: 300,
        alignment: Alignment.center,
      ),
      photoSize: 120,
      loadingText: Text(
        "Build-Ship-Run",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      loaderColor: Colors.red,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var url, cmd, webdata, txt;
  var index = 0;
  var db = ['--version', 'images', 'ps', 'ps -a'];
  web(cmd) async {
    url = "http://192.168.43.195/cgi-bin/web.py?x=${cmd}";
    var response = await http.get(url);

    setState(() {
      webdata = response.body;
      print(webdata);
    });
  }

  @override
  Widget build(BuildContext context) {
    var myScaffold = Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Image(
            image: AssetImage(
              "assets/docker.jpeg",
            ),
            width: 50,
            height: 50,
            alignment: Alignment.centerLeft,
          ),
        ],
        title: Text(
          "Welcome to Docker Hub!",
        ),
        backgroundColor: Colors.blue[200],
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 50, top: 50, right: 40, bottom: 20),
              child: TextField(
                autofocus: true,
                enabled: true,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    hintText: "Enter the Suffix e.g. images",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black))),
                onChanged: (value) {
                  cmd = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 100, right: 100, bottom: 20),
              alignment: Alignment.center,
              width: 20,
              height: 40,
              color: Colors.blue[400],
              child: FlatButton(
                onPressed: () => web(cmd),
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: 200,
                height: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.only(top: 50),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Text(
                      webdata ?? "Connecting to Docker",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
    return myScaffold;
  }
}
