import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newmap/Screen/SignUp_Login/SignIn.dart';
import 'package:newmap/Screen/User/Home/editBankPage.dart';
import 'package:newmap/Service/Network.dart';
import 'package:provider/provider.dart';

import 'EditAccountDetails.dart';

class ProfilePage extends StatefulWidget {


  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // WebServices network = Provider.of<WebServices>(context, listen: false);

    return Scaffold(
      backgroundColor:  Color(0xFF00A85A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  Color(0xFF00A85A),
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white, size: 18,),
        ),
      ),

      body: Consumer<WebServices>(
        builder: (context, network, child) {
          return Container(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(100),
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment(0.9,0.3),
                                    colors: [Color(0xFF00A85A).withOpacity(0.85),
                                      Color(0xFF006134).withOpacity(0.85),]),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.pink,

                              ),
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0, bottom:8, right:8, left:8),
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Color(0xFF4ca95b),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                            Colors.black26,
                                            blurRadius: 14,
                                            offset:
                                            Offset(1, 1))
                                      ],

                                  ),

                                  child: CircleAvatar(
                                    radius: 100,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    backgroundImage: network.path == 'path' ?
                                    FileImage(File(network.image.toString())):
                                    NetworkImage(network.image) as ImageProvider,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:5),
                        decoration: BoxDecoration(
                            color: Color(0xFF00A85A),
                            borderRadius: BorderRadius.circular(100),
                        border: Border.all(color:  Color(0xFF006134).withOpacity(0.4))
                        ),
                        height: 44,
                        width: 44,
                        child: Center(
                          child: IconButton(
                            onPressed: (){
                              getImage();
                            },
                            icon: Icon(Icons.camera_alt_outlined , color: Colors.white),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'ID: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: network.id.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading:  Container(
                            margin: EdgeInsets.only(left:5),
                            decoration: BoxDecoration(
                                color: Color(0xFF00A85A),
                                borderRadius: BorderRadius.circular(10),

                            ),
                            height: 40,
                            width: 40,
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  print('kkkkk');
                                },
                                icon: Icon(Icons.person , color: Colors.white),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right_alt_sharp, size: 35, color: Colors.white,),
                            onPressed: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return EditUserRegsiter();
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
                            },
                            padding: EdgeInsets.zero,
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return EditUserRegsiter();
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
                          },
                          title: Text('Name',  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                          subtitle: Text(network.username,
                            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),),
                        ),
                        ListTile(
                          leading:  Container(
                            margin: EdgeInsets.only(left:5),
                            decoration: BoxDecoration(
                              color: Color(0xFF00A85A),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            height: 40,
                            width: 40,
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  print('kkkkk');
                                },
                                icon: Icon(Icons.email_outlined , color: Colors.white),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right_alt_sharp, size: 35, color: Colors.white,),
                            onPressed: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return EditUserRegsiter();
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
                            },
                            padding: EdgeInsets.zero,
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return EditUserRegsiter();
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
                          },
                          title: Text('Email',  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                          subtitle: Text(network.myemail,
                            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),),
                        ),
                        ListTile(
                          leading:  Container(
                            margin: EdgeInsets.only(left:5),
                            decoration: BoxDecoration(
                              color: Color(0xFF00A85A),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            height: 40,
                            width: 40,
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  print('kkkkk');
                                },
                                icon: Icon(Icons.phone , color: Colors.white),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right_alt_sharp, size: 35, color: Colors.white,),
                            onPressed: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return EditUserRegsiter();
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
                            },
                            padding: EdgeInsets.zero,
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return EditUserRegsiter();
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
                          },
                          title: Text('Phone Number',  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                          subtitle: Text(network.myphonenumber,
                            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),),
                        ),

                      ],
                    ),
                    width: MediaQuery.of(context).size.width*0.85,
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(17)
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                //   child: Container(
                //     child: Column(
                //       children: [
                //         ListTile(
                //           leading:  Container(
                //             margin: EdgeInsets.only(left:5),
                //             decoration: BoxDecoration(
                //               color: Color(0xFF00A85A),
                //               borderRadius: BorderRadius.circular(10),
                //
                //             ),
                //             height: 40,
                //             width: 40,
                //             child: Center(
                //               child: IconButton(
                //                 onPressed: (){
                //                   print('kkkkk');
                //                 },
                //                 icon: Icon(Icons.password_rounded , color: Colors.white),
                //               ),
                //             ),
                //           ),
                //           onTap: (){
                //             Navigator.push(
                //               context,
                //               PageRouteBuilder(
                //                 pageBuilder:
                //                     (context, animation, secondaryAnimation) {
                //                   return EditUserRegsiter();
                //                 },
                //                 transitionsBuilder: (context, animation,
                //                     secondaryAnimation, child) {
                //                   return FadeTransition(
                //                     opacity: animation,
                //                     child: child,
                //                   );
                //                 },
                //               ),
                //             );
                //           },
                //           trailing: IconButton(
                //             icon: Icon(Icons.arrow_right_alt_sharp, size: 35, color: Colors.white,),
                //             onPressed: (){
                //               Navigator.push(
                //                 context,
                //                 PageRouteBuilder(
                //                   pageBuilder:
                //                       (context, animation, secondaryAnimation) {
                //                     return EditUserRegsiter();
                //                   },
                //                   transitionsBuilder: (context, animation,
                //                       secondaryAnimation, child) {
                //                     return FadeTransition(
                //                       opacity: animation,
                //                       child: child,
                //                     );
                //                   },
                //                 ),
                //               );
                //             },
                //             padding: EdgeInsets.zero,
                //           ),
                //           title:  Text('Change Password',
                //             style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),),
                //
                //         ),
                //
                //
                //       ],
                //     ),
                //     width: MediaQuery.of(context).size.width*0.85,
                //     height: 60,
                //     decoration: BoxDecoration(
                //         color: Colors.white12,
                //         borderRadius: BorderRadius.circular(17)
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading:  Container(
                            margin: EdgeInsets.only(left:5),
                            decoration: BoxDecoration(
                              color: Color(0xFF00A85A),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            height: 40,
                            width: 40,
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  print('kkkkk');
                                },
                                icon: Icon(Icons.account_balance_wallet_outlined , color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return EditBankPage();
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
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right_alt_sharp, size: 35, color: Colors.white,),
                            onPressed: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return EditBankPage();
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
                            },
                            padding: EdgeInsets.zero,
                          ),
                          title:  Text('Bank Details',
                            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),),

                        ),


                      ],
                    ),
                    width: MediaQuery.of(context).size.width*0.85,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(17)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0, bottom: 15, left: 40, right: 40),
                  child: ElevatedButton(
                    style:  ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(54.0),
                            )
                        )
                    ),

                    child: Container(
                      width: 250,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: Colors.red,),
                          Text('Sign Out', style: TextStyle(color: Colors.red,)),
                        ],
                      ),
                    ),
                    onPressed: () {
                      final box = GetStorage();
                      box.erase();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return SignIn();
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
                    },
                  ),
                ),
              ],
            ),

          );
        }
      ),
    );
  }


  File ?image;
  final picker = ImagePicker();
  Future getImage() async {
    WebServices network = Provider.of<WebServices>(context, listen: false);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile!.path);

    });


    network.uploadImage(imagePath:image!.path, context:context);
  }
}
