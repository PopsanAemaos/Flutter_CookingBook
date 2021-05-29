import 'package:flutter/material.dart';
import 'package:my_app/services/authentication.dart';

class Favorite extends StatefulWidget {
  Favorite({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(''),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Favorite',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
          ],
        ),
    );
  }
}