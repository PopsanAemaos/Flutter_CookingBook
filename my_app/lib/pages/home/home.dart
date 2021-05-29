import 'dart:async';
import 'package:my_app/services/authentication.dart';

import 'package:flutter/material.dart';
import 'package:my_app/services/http.dart';
import 'package:my_app/pages/home/list-recipe.dart';
import 'package:my_app/models/recipe.dart';

class Home extends StatefulWidget {
  Home({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  final TextEditingController _controller = new TextEditingController();
  final HttpService httpService = HttpService();
  // List<AddFood> loadedFoods = [];
  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();
  String searchString = "";

  _SearchListState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    // _querystring = "";
    super.initState();
    _isSearching = false;
    // var request = http.Request(
    //     'GET',
    //     Uri.parse('http://localhost:3030/recipe?'));
    // http.StreamedResponse response = await request.send();
    // Map<String, dynamic> responseJson =
    //     jsonDecode(await response.stream.bytesToString());
    // userId = responseJson["_id"];
    // print('Signed in: $userId');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      print(searchText);
      // for (int i = 0; i < _list.length; i++) {
      //   String data = _list[i];
      //   if (data.toLowerCase().contains(searchText.toLowerCase())) {
      //     searchresult.add(data);
      //   }
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: MyWidget());
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    color: Color(getColorHexFromStr('#FF2C00')),
                  ),
                  Positioned(
                    bottom: 70.0,
                    right: 150.0,
                    child: Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(getColorHexFromStr('#892612'))
                              .withOpacity(0.4)),
                    ),
                  ),
                  Positioned(
                    bottom: 100.0,
                    left: 150.0,
                    child: Container(
                        height: 300.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.0),
                            color: Color(getColorHexFromStr('#892612'))
                                .withOpacity(0.5))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20.0),
                          Container(
                            alignment: Alignment.topLeft,
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Profile Image.png'))),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 120.0),
                          SizedBox(height: 15.0),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Hello , Pino',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Padding(
                        // search
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        // child: new ListRecipe()
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(5.0),
                          child: TextFormField(
                              controller: _controller,
                              // onChanged: (value) {
                              //   setState((){
                              //     searchString = value;
                              //   });
                              // },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search,
                                      color:
                                          Color(getColorHexFromStr('#FEDF62')),
                                      size: 30.0),
                                  contentPadding:
                                      EdgeInsets.only(left: 15.0, top: 15.0),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand'))),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // MyWidget()
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              itemCard('FinnNavian', 'assets/ottomRan.jpg', false, 'sss'),
              // itemCard('FinnNavian', 'assets/anotherchair.jpg', true),
              // itemCard('FinnNavian', 'assets/chair.jpg', true)
            ],
          ),
        ],
      ),
    );
  }

  Widget itemCard(
      String title, String imgPath, bool isFavorite, String description) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Container(
        height: 150.0,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: 140.0,
              height: 150.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.cover)),
            ),
            SizedBox(width: 4.0),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 45.0),
                    Material(
                      elevation: isFavorite ? 0.0 : 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: isFavorite
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.white),
                        child: Center(
                          child: isFavorite
                              ? Icon(Icons.favorite_border)
                              : Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5.0),
                Container(
                  width: 175.0,
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.grey,
                        fontSize: 12.0),
                  ),
                ),
                SizedBox(height: 5.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FutureBuilder(
            future: httpService.getRecipe(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
              print(snapshot);
              print("snapshot");
              if (snapshot.hasData) {
                List<Recipe> recipes = snapshot.data;
                print(recipes);
                return ListView(
                    children: recipes
                        .map((Recipe recipe) => ListTile(
                              title: Text(recipe.title),
                              subtitle: Text(recipe.description.toString()),
                            ))
                        .toList());
              }
              return CircularProgressIndicator();
            }));
  }
}
