import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_app/models/teams.dart';
import 'package:nba_app/models/teamsdetails.dart';


void main() => runApp(MaterialApp(
      title: "NBA App",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
   var url = "https://data.nba.net/prod/v2/2019/teams.json";

   TeamsList teamsList;

    @override
    void initState() {
      super.initState();
      fetchData();
    }

    fetchData() async {
      var res = await http.get(url);
      var decodedJson = jsonDecode(res.body);
      teamsList = TeamsList.fromJson(decodedJson);
      print(teamsList.toJson());
      setState(() {});
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NBA App"),
        backgroundColor: Colors.cyan,
      ),
      body: teamsList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: teamsList.teams
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TeamDetail(
                                          teams: poke,
                                        )));
                          },
                          child: Hero(
                            tag: poke.fullName,
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage('https://a.espncdn.com/i/teamlogos/nba/500/'+ poke.tricode+'.png'))),
                                  ),
                                  Text(
                                    poke.fullName,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}