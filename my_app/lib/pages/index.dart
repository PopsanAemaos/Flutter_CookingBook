import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/pages/home/home.dart';
import 'package:my_app/pages/bottomBar/mylist.dart';
import 'package:my_app/pages/bottomBar/favorite.dart';
import 'package:my_app/pages/profile/profile.dart';

class Index extends StatefulWidget {
  Index({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _IndexState();
  void signOut() async {
    try {
      print(this.auth);
      await this.auth.signOut();
      this.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  @override
  TabController controller;
  static const routeName = '/';
  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[
    new Home(),
    Favorite(),
    Mylist(),
    ProfileScreen(),
  ];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.solidHeart),
      title: Text('Favorite'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.list),
      title: Text('Mylist'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.userAlt),
      title: Text('Profile'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        title: new Text('Flutter login demo'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
