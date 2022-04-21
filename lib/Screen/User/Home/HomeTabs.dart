import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newmap/Screen/User/Home/AgentMap.dart';
import 'package:newmap/Screen/User/Home/Homepage.dart';
import 'package:newmap/Screen/User/Home/Notification.dart';
import 'package:newmap/Screen/User/Home/Profile.dart';
import 'package:newmap/Service/Network.dart';
import 'package:provider/provider.dart';



class  HomePageTab extends StatefulWidget {
  HomePageTab();

  @override
  _HomePageTabState createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  PageController ?_myPage;
  var search;
  final scafoldKey = GlobalKey<ScaffoldState>();







  @override
  void initState() {
    super.initState();
 _myPage = PageController(initialPage: 0, viewportFraction: 1);
  }



  @override
  void dispose() {
    _myPage!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // var data = Provider.of<DataProvider>(context, listen: false);



    bool shouldPop = true;
    var widget = Scaffold(
      key: scafoldKey,
      // drawer: SizedBox(
      //   width: 250,
      //   child: Drawer(
      //     child: DrawerWidget(context, _myPage),
      //   ),
      // ),
      bottomNavigationBar: Container(
              height: 60,
              child: BottomNavigationBar(
                  onTap: (index) {
                   if(index== 1){
                     Navigator.push(
                                         context,
                                         PageRouteBuilder(
                                           pageBuilder:
                                               (context, animation, secondaryAnimation) {
                                             return AgentMap();
                                           },
                                           transitionsBuilder: (context, animation,
                                               secondaryAnimation, child) {
                                             return FadeTransition(
                                               opacity: animation,
                                               child: child,
                                             );
                                           },
                                         ),
                                       );
                   }else  if(index== 2){
                     Navigator.push(
                       context,
                       PageRouteBuilder(
                         pageBuilder:
                             (context, animation, secondaryAnimation) {
                           return NotificationPage();
                         },
                         transitionsBuilder: (context, animation,
                             secondaryAnimation, child) {
                           return FadeTransition(
                             opacity: animation,
                             child: child,
                           );
                         },
                       ),
                     );
                   }else  if(index== 3){
                     Navigator.push(
                       context,
                       PageRouteBuilder(
                         pageBuilder:
                             (context, animation, secondaryAnimation) {
                           return ProfilePage();
                         },
                         transitionsBuilder: (context, animation,
                             secondaryAnimation, child) {
                           return FadeTransition(
                             opacity: animation,
                             child: child,
                           );
                         },
                       ),
                     );
                   }


                   else{
                     _myPage!.jumpToPage(index);
                   }
                    // if (index == conData.selectedPage) {
                    // } else {
                    //   setState(() {
                    //     _myPage!.jumpToPage(index);
                    //     conData.setSelectedBottomNavBar(index);
                    //   });
                    //
                    // }
                  },
                  elevation: 20,
                  type: BottomNavigationBarType.fixed,
                 // currentIndex: conData.selectedPage,
                  unselectedItemColor: Color(0xFF555555),
                  selectedItemColor: Color(0xFF00A85A),
                  selectedLabelStyle: TextStyle(fontSize: 12),
                  unselectedLabelStyle: TextStyle(fontSize: 12),
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: Icon(
                          Icons.apps_outlined,
                          size: 20,
                        ),
                      ),
                      label: 'Home',
                    ),

                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Icon(Icons.people_rounded,
                          size:20, ),
                      ),
                      label: 'Agents',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child:  Icon(
                          Icons.notifications_active,
                          size: 24,),
                      ),
                      label: 'Notifications',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Icon(Icons.person),
                      ),
                      label: 'Profile',
                    )
                  ]),
            ),


      body: WillPopScope(
        onWillPop: ()async{
           showDialog(
              context: context,
              builder: (ctx) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: AlertDialog(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    content: Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Oops!!',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF00A85A),
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Center(
                                  child: Text(
                                    'DO YOU WANT TO EXIT THIS APP?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(26),
                                  elevation: 2,
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF00A85A)),
                                        borderRadius:
                                        BorderRadius.circular(26)),
                                    child: FlatButton(
                                      onPressed: () {
                                         exit(0);
                                      },
                                      color: Color(0xFF00A85A),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(26)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(26)),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 190.0, minHeight: 53.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Yes",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  borderRadius: BorderRadius.circular(26),
                                  elevation: 2,
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF00A85A)),
                                        borderRadius:
                                        BorderRadius.circular(26)),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color:Color(0xFF00A85A),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(26)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(26)),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 190.0, minHeight: 53.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "No",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                );
              });
           return shouldPop;
        },
        child: PageView(
          controller: _myPage,
          physics: NeverScrollableScrollPhysics(),
          children: [
            UserHomePage(),
            AgentMap(),
            NotificationPage(),
            Text('')
            // PostScreen(),
            // NotificationPage(scafoldKey,  _myPage),
            // PendingScreen(scafoldKey),
          ],
        ),
      ),
    );

    return widget;
  }
}


//
//
// handlebackgrundMessage(message)async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var id = prefs.getString('user_id');
//   userid.newid = int.parse(id);
//   FirebaseApi.uploadCheckNotify(
//     userid.newid.toString(),
//   );
//   FirebaseApi.uploadNotification(
//       userid.newid.toString(),
//       message.notification.title,
//       message.data["notification_type"],
//       '${message.data["lastName"]} ${message.data["firstName"]}',
//       '${message.data["jobId"]}',
//       '${message.data["bidId"]}',
//       '${message.data["bidderId"]}',
//       '${message.data["artisanId"]}',
//       '${message.data['budget']}',
//       '${message.data['invoiceId']}',
//       '${message.data['service_id']}'
//
//   );
//
// }
//
//
// bool count = true;
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   count?setup():null;
//   count = false;
//   await Firebase.initializeApp();
//   handlebackgrundMessage(message);
// }
