

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newmap/Screen/Agent/AgentRegistration.dart';
import 'package:newmap/Widget/powered.dart';

import 'SignIn.dart';
import 'UserRegistration.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              child: Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.grey,
                      BlendMode.saturation,
                    ),
                    child: Container(
                        height: MediaQuery.of(context).size.height/1.4,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/images/recycle.jpeg',
                          alignment: new Alignment(0.27, 0.0),
                          scale: 1.5,
                          fit: BoxFit.none,)),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment(0,0.3),
                            colors: [Colors.transparent, Color(0xFFFCFFFD)]),
                      ),
                      child: Text('')),
                 Container(
                   alignment: Alignment.bottomLeft,
                   height: MediaQuery.of(context).size.height,
                   width: MediaQuery.of(context).size.width,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Regsiter', style: TextStyle(color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: ElevatedButton(
                              style:  ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xFF00A85A)),
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
                                child: Text('Register as a User'),
                              ),
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation, secondaryAnimation) {
                                      return UserRegsiter();
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

                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: TextButton(
                              style:  ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(54.0),
                                      )
                                  )
                              ),

                              child: Container(
                                width: 280,
                                height: 55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF00A85A)),
                                    borderRadius: BorderRadius.circular(54)),
                                child: Text('Register as an Agent', style: TextStyle(color:  Color(0xFF00A85A)),),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) {
                                      return AgentRegsiter();
                                    },
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                          Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () async {
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
                                  child: Center(
                                      child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: 'Already have an account? ',
                                              style: TextStyle(color: Colors.black26, fontSize: 16)
                                            ),
                                            TextSpan(
                                              text: 'Sign in',
                                                style: TextStyle(color:  Color(0xFF00A85A), fontSize: 16)
                                            )
                                          ]))))),
                          poweredBy()
                        ],
                      ),
                 ),
                ],
              ),
            ),
            Platform.isIOS?Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black)),
            ):Container()
          ],
        ));
  }
}
