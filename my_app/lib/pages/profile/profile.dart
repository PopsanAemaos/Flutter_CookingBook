import 'package:flutter/material.dart';
import 'package:my_app/services/authentication.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;  
  void signOut() async {
    print(userId);
    // flutter: SDicxbI1SIaCMXEr1aEfIhc3bAB2
    try {
      await auth.signOut();
      logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  final VoidCallback logoutCallback;
  final String userId;

  static String routeName = "/profile";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ProfilePic(),
              SizedBox(height: 20),
              // ProfileMenu(
              //   text: "My Account",
              //   icon: "assets/icons/User Icon.svg",
              //   press: () => {},
              // ),
              // ProfileMenu(
              //   text: "Notifications",
              //   icon: "assets/icons/Bell.svg",
              //   press: () {},
              // ),
              // ProfileMenu(
              //   text: "Settings",
              //   icon: "assets/icons/Settings.svg",
              //   press: () {},
              // ),
              // ProfileMenu(
              //   text: "Help Center",
              //   icon: "assets/icons/Question mark.svg",
              //   press: () {},
              // ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () {
                  signOut();
                },
              ),
            ],
          ),
        ));
  }
}
