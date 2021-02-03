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
      seconds: 5,
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
  var url, cmd, webdata;
  var index = 0;
  var db = ['images', 'ps', 'ps -a'];

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
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blueGrey[100]),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            Card(
              child: FlatButton(
                onPressed: () => web(db[index]),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/pilates.png"))),
                    child: Text(webdata ?? "loading")),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateImage())),
                child: Image.asset("assets/image.png"),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateImage()));
                },
                child: Image.asset("assets/cargo.png"),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateImage())),
                child: Image.asset("assets/volumes.png"),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateImage())),
                child: Image.asset("assets/man-pushing.png"),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateImage())),
                child: Image.asset("assets/eraser.png"),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateImage())),
                child: Image.asset("assets/running.png"),
              ),
            ),
            Card(
              child: FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateImage())),
                child: Image.asset("assets/no-stopping.png"),
              ),
            ),
          ],
        ),
      ),
    );
    return myScaffold;
  }

  CreateImage() {
    return Container(
      color: Colors.white,
      child: FlatButton(
          onPressed: () => web(cmd), child: Text(webdata ?? "printing..")),
      //child: RaisedButton(onPressed: () => Navigator.pop(context)),
    );
  }
}
