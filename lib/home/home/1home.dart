import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pim/home/appointment/appointment_page.dart';
import 'package:pim/home/contact/contact_page.dart';
import 'package:pim/home/home/about_page.dart';
import 'package:pim/home/note/notes_page.dart';
import 'package:pim/home/home/setting.dart';
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
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PimUser>(context);

    return StreamBuilder<PimUserData>(
        stream: UserDbService(uid: user.uid).getUserData,
        builder: (context, snapshot) {
          PimUserData userData =
              snapshot.data ?? PimUserData(name: 'New User', email: 'Email id');
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                      accountName: Text(
                        userData.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                      accountEmail: Text(
                        userData.email,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                      decoration: BoxDecoration(color: c2),
                      currentAccountPicture: CircleAvatar(
                          backgroundColor: c1,
                          child: Text(
                            userData.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600),
                          ))),
                  ListTile(
                      title: Text('User Settings'),
                      leading: Icon(Icons.settings),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingPage(userData)));
                        // Navigator.pop(context);
                      }),
                  Divider(
                    height: 5.0,
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      print('LogOut Sucessfully');
                    },
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  ListTile(
                      title: Text('About us'),
                      leading: Icon(Icons.info_outline),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()));
                      }),
                ],
              ),
            ),
            appBar: AppBar(
                title: Text(
                  'PIM',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  labelColor: c1,
                  unselectedLabelColor: c3,
                  tabs: [
                    Tab(
                        text: 'Appointment',
                        icon: Icon(
                          Icons.calendar_today,
                          size: 26.0,
                        )),
                    Tab(
                        text: 'Contacts',
                        icon: Icon(
                          Icons.contacts,
                          size: 26.0,
                        )),
                    Tab(
                        text: 'Notes',
                        icon: Icon(
                          Icons.event_note,
                          size: 26.0,
                        )),
                    Tab(
                        text: 'Tasks',
                        icon: Icon(
                          Icons.assignment,
                          size: 26.0,
                        )),
                  ],
                )),
            body: TabBarView(controller: _tabController, children: [
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
            ]),
          );
        });
  }
}
