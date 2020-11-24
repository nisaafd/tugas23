import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final String appName = "Counting App";
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      home: Counting(),
    );
  }
}

class Counting extends StatefulWidget {
 @override
 _CountingState createState() => _CountingState();
}


class _CountingState extends State<Counting> {
  BuildContext _context;
  int _pointTimA = 0; 
  int _pointTimB = 0; 
  Color _pointTimAColor = Colors.black; 
  Color _pointTimBColor = Colors.black; 

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        title: Text(
          appName,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.black,
            onPressed: _resetGame,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            playerInformation(playerName: "Tim A"),
            playerInformation(playerName: "Tim B"),
          ],
        ),
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _pointTimA = _pointTimB = 0; 
      _pointTimAColor = _pointTimBColor = Colors.black; 
    });
  }

  void _timAcetakPoin() {
    setState(() {
      _pointTimA++; 
      _scoreHighlighter(); 
    });
  }
  
  void _cupheadExmove() {
    setState(() {
      _pointTimA--; 
      _scoreHighlighter(); 
    });
  }

  void _timBcetakPoin() {
    setState(() {
      _pointTimB++; 
      _scoreHighlighter(); 
    });
  }

  void _mugmanExmove() {
    setState(() {
      _pointTimB--; 
      _scoreHighlighter(); 
    });
  }

  
  void _scoreHighlighter() {
    if (_pointTimA > _pointTimB) {
      _pointTimAColor = Colors.green[800];
      _pointTimBColor = Colors.red[800];
    } else if (_pointTimB > _pointTimA) {
      _pointTimBColor = Colors.green[800];
      _pointTimAColor = Colors.red[800];
    } else {
      _pointTimAColor = _pointTimBColor = Colors.black;
    }
  }

   
  Widget playerInformation({@required String playerName}) {
    List<Color> colors = [Colors.red[100], Colors.red[400], Colors.red[500]];
    String playerImage = "assets/boy.png";
    double playerImagePadding = 12;

    if (playerName == "Tim B") {
      colors = [];
      colors.add(Colors.blue[100]);
      colors.add(Colors.blue[400]);
      colors.add(Colors.blue[500]);
      playerImage = "assets/boy2.png";
      playerImagePadding = 38;
    }

    return Expanded(
      flex: 1,
      child: Container(
        color: colors[0],
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            // Player Name
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                playerName,
                style: TextStyle(color: colors[2], fontWeight: FontWeight.bold),
              ),
            ),

            // Player Score
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                playerName == "Tim A"
                    ? _pointTimA.toString()
                    : _pointTimB.toString(),
                style: TextStyle(
                    color: playerName == "Tim A"
                        ? _pointTimAColor
                        : _pointTimBColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 54),
              ),
            ),
 
            SizedBox(
              height: 170,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(playerImagePadding),
                child: Image.asset(playerImage),
              ),
            ),
             

               
            Container(
              margin: EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  splashColor: Colors.white,
                  onPressed:
                      playerName == "Tim A" ? _timAcetakPoin : _timBcetakPoin,
                  color: colors[1],
                  child: Text(
                    "Tambah Point",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ), 

            Container(
              margin: EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  splashColor: Colors.white,
                  onPressed:
                      playerName == "Tim B" ? _cupheadExmove : _mugmanExmove,
                  color: colors[1],
                  child: Text(
                    "Kurang Point",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows Dialog with name of Winner when either of player's HP reaches 0
  void showWinnerDialog(String winner) {
    showDialog(
        context: _context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("$winner Won"),
            ));
  }
}
