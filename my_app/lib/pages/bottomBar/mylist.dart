import 'package:flutter/material.dart';
import 'package:my_app/services/authentication.dart';

class Mylist extends StatefulWidget {
  Mylist({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _MylistState();
}

class _MylistState extends State<Mylist> {
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
                child: new Text('Mylist',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
          ],
        ),
    );
  }
}