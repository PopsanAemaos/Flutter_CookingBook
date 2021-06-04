import 'package:flutter/material.dart';
import 'package:my_app/services/http.dart';
import 'package:my_app/models/recipe.dart';
import 'package:my_app/services/authentication.dart';

class Favorite extends StatefulWidget {
   Favorite({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _FavoriteState createState() => new _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Favorite"),
        ),
        body: FutureBuilder(
            future: httpService.getRecipe(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
              if (snapshot.hasData) {
                List<Recipe> recipes = snapshot.data;
                print("1sdsdvdvvfvf");
                print(recipes);
                print("2sdsdvdvvfvf");
                return ListView(
                    children: recipes
                        .map((Recipe recipe) =>ListTile(
                          title:Text(recipe.title)
                        ))
                        .toList());
              }
              return CircularProgressIndicator();
            }));
  }
}
