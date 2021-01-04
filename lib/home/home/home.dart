import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pim/home/appointment/appointment_page.dart';
import 'package:pim/home/contact/contact_page.dart';
import 'package:pim/home/home/about_page.dart';
import 'package:pim/home/home/contact.dart';
import 'package:pim/home/home/setting.dart';
import 'package:pim/home/note/notes_page.dart';
import 'package:pim/home/task/tasks_page.dart';
import 'package:pim/models/pim_user.dart';
import 'package:pim/service/database/user_data.dart';
import 'package:pim/shared/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final menu = new Menu(
    items: [
      new MenuItem(id: 'home', title: 'Home', icon: Icons.home),
      new MenuItem(id: 'about', title: 'About Us', icon: Icons.person),
      new MenuItem(id: 'contact', title: 'Contact', icon: Icons.phone),
      new MenuItem(id: 'setting', title: 'Setting', icon: Icons.settings),
      new MenuItem(
          id: 'logout', title: 'Log Out', icon: Icons.exit_to_app_rounded),
    ],
  );

  var selectedMenuItemId = 'home';
  TabController _tabController;
  Text _appbarText;
  Color _appbarColor;
  Color _appiconColor;
  bool _center;
  bool _elevation;

  @override
  void initState() {
    super.initState();
    _changesOccur();
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget headerView(BuildContext context, PimUserData user) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
              new Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/icons/pim_new_logo.png")))),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        )
      ],
    );
  }

  _changesOccur() {
    if (selectedMenuItemId == 'home') {
      setState(() {
        _appbarText = Text(
          'Home',
          style: TextStyle(color: Colors.black),
        );
        _center = false;
        _appbarColor = Colors.white;
        _appiconColor = c2;
        _elevation = true;
      });
    } else if (selectedMenuItemId == 'about') {
      setState(() {
        _appbarText = Text(
          '',
        );
        _center = false;
        _appbarColor = c1;
        _appiconColor = Colors.black;
        _elevation = false;
      });
    } else if (selectedMenuItemId == 'contact') {
      setState(() {
        _appbarText = Text(
          'Contact Us',
          style: TextStyle(color: Colors.white),
        );
        _center = true;
        _appbarColor = Colors.deepPurple;
        _appiconColor = Colors.white;
        _elevation = false;
      });
    } else if (selectedMenuItemId == 'setting') {
      setState(() {
        _appbarText = Text(
          'Setting',
          style: TextStyle(color: Colors.white),
        );
        _center = true;
        _appbarColor = c5;
        _appiconColor = Colors.white;
        _elevation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PimUser>(context);
    return StreamBuilder<PimUserData>(
        stream: UserDbService(uid: user.uid).getUserData,
        builder: (context, snapshot) {
          PimUserData userData =
              snapshot.data ?? PimUserData(name: 'New User', email: 'Email id');
          return DrawerScaffold(
            drawers: [
              SideDrawer(
                // background: DecorationImage(
                //     image: AssetImage('assets/icons/pim_new_logo.png'),
                //     fit: BoxFit.contain),
                // direction:Direction.right,
                // percentage: 0.9,
                // alignment: Alignment.centerLeft,
                degree: 45, drawerWidth: 150,
                menu: menu,
                headerView: headerView(context, userData),
                // animation: true,
                color: Theme.of(context).primaryColor,
                selectedItemId: selectedMenuItemId,
                selectorColor: gold,
                onMenuItemSelected: (itemId) async {
                  setState(() {
                    selectedMenuItemId = itemId;
                  });
                  _changesOccur();

                  if (itemId == 'logout') {
                    await FirebaseAuth.instance.signOut();
                    print('LogOut Sucessfully');
                  }
                },
              )
            ],
            appBar: AppBar(
                backgroundColor: _appbarColor,
                elevation: _elevation ? 4.0 : 0.0,
                centerTitle: _center,
                iconTheme: IconThemeData(
                  color: _appiconColor,
                ),
                title: _appbarText,
                bottom: selectedMenuItemId == 'home'
                    ? TabBar(
                        controller: _tabController,
                        labelColor: c1,
                        unselectedLabelColor: c3,
                        tabs: [
                          Tab(
                              text: 'Appointment',
                              icon: Image.asset(
                                'assets/icons/Appointment_Icon.png',
                                height: 26.0,
                                width: 26.0,
                                color: _tabController.index == 0 ? c1 : c3,
                              )),
                          Tab(
                              text: 'Contacts',
                              icon: Icon(
                                Icons.contacts,
                                size: 26.0,
                              )),
                          Tab(
                              text: 'Notes',
                              icon: Image.asset('assets/icons/Note_Icon.png',
                                  height: 26.0,
                                  width: 26.0,
                                  color: _tabController.index == 2 ? c1 : c3)),
                          Tab(
                              text: 'Tasks',
                              icon: Image.asset('assets/icons/Task_Icon.png',
                                  height: 26.0,
                                  width: 26.0,
                                  color: _tabController.index == 3 ? c1 : c3)),
                        ],
                      )
                    : null),
            contentView: Screen(
              contentBuilder: (context) {
                if (selectedMenuItemId == 'home') {
                  return TabBarView(controller: _tabController, children: [
                    HomePage(), // first page
                    ContactPage(
                      user: user,
                    ), // second page
                    NotesPage(
                      user: user,
                    ), //third page
                    TaskPage(
                      user: user,
                    ) //forth page
                  ]);
                } else if (selectedMenuItemId == 'about') {
                  return AboutPage();
                } else if (selectedMenuItemId == 'contact') {
                  return Contact(
                    user: userData,
                  );
                } else if (selectedMenuItemId == 'setting') {
                  return SettingPage(userData);
                }
              },
              color: Colors.white,
            ),
          );
        });
  }
}
