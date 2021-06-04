import 'package:flutter/material.dart';
import 'package:my_app/services/http.dart';
import 'package:my_app/models/recipe.dart';
import 'package:my_app/pages/mylist/list_detail.dart';
import 'package:my_app/pages/mylist/list_add.dart';
import 'package:my_app/services/authentication.dart';

class MyList extends StatefulWidget {
  MyList({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _MyListState createState() => new _MyListState();
}

class _MyListState extends State<MyList> {
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

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<List<Recipe>> _getData() async {
    var values = httpService.findRecipeByUser(widget.userId);
    await new Future.delayed(new Duration(seconds: 1));

    return values;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("My Food List")
      ),
      body: FutureBuilder(
          future: _getData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
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
                                color: Color(getColorHexFromStr("#F5F5F5")),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 15.0),
                                    Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(recipe.images),
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
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          width: 250.0,
                                          child: Text(
                                            recipe.description.toString(),
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
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
                                        ListDetail(recipe: recipe))),
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
                        height: 400.0
                      );
            // return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListAdd(user_id: widget.userId))) ,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
