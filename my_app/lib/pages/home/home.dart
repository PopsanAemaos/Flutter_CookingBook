import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/services/http.dart';
import 'package:my_app/models/recipe.dart';
import 'package:my_app/pages/home/detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();
  String searchString = "";

  final HttpService httpService = HttpService();

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

  Widget appBarTitle = new Text(
    "Search Example",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.red,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;

  _HomeState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _getData();
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _getData();
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  Future<List<Recipe>> _getData() async {
    print(_searchText);
    var values = httpService.findRecipe(_searchText);
    await new Future.delayed(new Duration(seconds: 1));

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Yummy Trick"),
        ),
        key: globalKey,
        body: Column(
          children: [
            Container(
                height: 250.0,
                child: new ListView(
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
                                      borderRadius:
                                          BorderRadius.circular(150.0),
                                      color:
                                          Color(getColorHexFromStr('#892612'))
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
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          border: Border.all(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 1.0),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Profile Image.png'))),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                120.0),
                                    SizedBox(height: 15.0),
                                  ],
                                ),
                                SizedBox(height: 50.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Hello',
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 50.0),
                                Padding(
                                  // search
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  // child: new ListRecipe()
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: TextFormField(
                                        controller: _controller,
                                        onChanged: (value) {
                                          setState(() {
                                            print(value);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.search,
                                              color: Color(getColorHexFromStr(
                                                  '#FEDF62')),
                                              size: 30.0),
                                          contentPadding: EdgeInsets.only(
                                              left: 15.0, top: 15.0),
                                          hintText: 'Search',
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Quicksand'),
                                          suffixIcon: IconButton(
                                            onPressed: () => {
                                              _controller.clear(),
                                              _searchText = ""
                                            },
                                            icon: Icon(Icons.clear),
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                // MyWidget()
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            Expanded(
                child: FutureBuilder(
                    // future: httpService.getRecipe(),
                    future: _getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Recipe>> snapshot) {
                      if (snapshot.hasData) {
                        List<Recipe> recipes = snapshot.data;
                        return ListView(
                            children: recipes
                                .map((Recipe recipe) => InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, right: 15.0, top: 15.0),
                                        child: Container(
                                          height: 120.0,
                                          width: double.infinity,
                                          color: Color(
                                              getColorHexFromStr("#F5F5F5")),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(width: 15.0),
                                              Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            recipe.images),
                                                        fit: BoxFit.cover)),
                                              ),
                                              SizedBox(width: 10.0),
                                              Column(
                                                children: <Widget>[
                                                  SizedBox(height: 10.0),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        recipe.title,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Quicksand',
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Container(
                                                    width: 250.0,
                                                    child: Text(
                                                      recipe.description
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Quicksand',
                                                          color: Colors.black,
                                                          fontSize: 10.0),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                 Detail(recipe: recipe))),
                                    ))
                                .toList());
                      }
                      return SizedBox(
                        child: Transform.scale(
                          scale: 0.1,
                          child: CircularProgressIndicator(
                            strokeWidth: 20,
                          ),
                        ),
                        width: 1000.0,
                      );
                    }))
          ],
        ));
  }

  // void searchOperation(String searchText) {
  //   searchresult.clear();
  //   print(searchText);
  //   print(searchresult);
  //   if (_isSearching != null) {
  //     for (int i = 0; i < _list.length; i++) {
  //       String data = _list[i];
  //       if (data.toLowerCase().contains(searchText.toLowerCase())) {
  //         searchresult.add(data);
  //       }
  //     }
  //   }
  // }
}
