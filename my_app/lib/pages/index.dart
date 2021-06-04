import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/pages/mylist/mylist.dart';
import 'package:my_app/pages/home/home.dart';
import 'package:my_app/pages/favorite/favorite.dart';
import 'package:my_app/pages/profile/profile.dart';

class Index extends StatefulWidget {
  Index({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  State<StatefulWidget> createState() => new _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  TabController controller;
  int _selectedIndex = 0;
  void signOut() async {
    print(widget.userId);
    // flutter: SDicxbI1SIaCMXEr1aEfIhc3bAB2
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // _pageWidget.add(
    //   Favorite(userId: widget.userId),
    // );
    _pageWidget.add(
      MyList(userId: widget.userId),
    );
    _pageWidget.add(
      ProfileScreen(
          userId: widget.userId,
          auth: widget.auth,
          logoutCallback: widget.logoutCallback),
    );
  }

  List<Widget> _pageWidget = <Widget>[
    Home(),
    // Favorite(),
    // MyList(userId: userId,),
    // ProfileScreen(),
  ];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.home),
      // ignore: deprecated_member_use
      title: Text('Home'),
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(FontAwesomeIcons.solidHeart),
    //   // ignore: deprecated_member_use
    //   title: Text('Favorite'),
    // ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.list),
      // ignore: deprecated_member_use
      title: Text('Mylist'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.userAlt),
      // ignore: deprecated_member_use
      title: Text('Profile'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Yummy trick'),
        // actions: <Widget>[
        //   new FlatButton(
        //       child: new Text('Logout',
        //           style: new TextStyle(fontSize: 17.0, color: Colors.white)),
        //       onPressed: signOut)
        // ],
      // ),
      body: _pageWidget[_selectedIndex],
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
