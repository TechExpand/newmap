
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmap/Model/Transaction.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Screen/User/Home/AgentMap.dart';
import 'package:newmap/Screen/Wallet/AirtimeDetails.dart';
import 'package:newmap/Screen/Wallet/Wallet.dart';
import 'package:newmap/Service/Network.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  List<Transaction> ?transaction;



  calltransaction(context)async{
    var network = Provider.of<WebServices>(context, listen: false);
    network.getUserTransaction().then((value) {
      setState(() {
        transaction = value ;
      });
    });
  }
  var info;

  @override
  void initState(){
    super.initState();
    var network = Provider.of<WebServices>(context, listen: false);
   info =  network.getUserInfo();
    calltransaction(context);
    // plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
   // WebServices network = Provider.of<WebServices>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFFCFFFD),
      body: FutureBuilder(
        future: info,
        builder: (context,AsyncSnapshot snapshot) {
          return !snapshot.hasData? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Theme(
                  data: Theme.of(context).copyWith(
                    accentColor: Color(0xFF00A85A),),
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A85A)),
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                    //  valueColor: new AlwaysStoppedAnimation<Color>(color: Color(0xFF9B049B)),
                  )),
              SizedBox(
                height: 10,
              ),
              Text('Loading',
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ],
          )):
          Consumer<WebServices>(
            builder: (context, network, child) {
              return Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Row(
                        children: [
                  Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom:8, right:8, left:18),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFF4ca95b),
                          border: Border.all(color: Color(0xFF4ca95b,),width: 2)
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          backgroundImage: network.path == 'path' ?
                          FileImage(File(network.image.toString())):
                          NetworkImage(network.image) as ImageProvider,
                        ),
                      ),
                  ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text('Welcome back, 👋'),
                              Text(network.username.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top:16.0, right:18, ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Color(0xFF4ca95b),
                                      border: Border.all(color: Color(0xFF4ca95b,),width: 2)
                                  ),
                                  child: CircleAvatar(
                                      radius: 25,
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage('assets/images/edo.png')
                                  ),
                                ),
              RichText(
                text: TextSpan(
                  text: 'ID: ',
                  style: TextStyle(
                        fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black54),
                  children: <TextSpan>[
                      TextSpan(
                            text: network.localID.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                  ],
                ),
              )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: MediaQuery.of(context).size.width*0.05),
                      child: Stack(
                        children: [
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                      child: Image.asset('assets/images/green.png', fit: BoxFit.cover,)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)
                                  ),
                                ),
                                Positioned(
                                  right: -30,
                                  top: -70,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text(''),
                                    width: 210,
                                    height: 210,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment(0.9,0.3),
                                            colors: [Color(0xFF00A85A).withOpacity(0.85),
                                              Color(0xFF006134).withOpacity(0.85),]),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top:30, left: 20, right:20),
                            child: Row(
                              children: [
                               Column(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text('Balance', style: TextStyle(color:Colors.white),),
                                   ),
                                   Text("₦${double.parse(network.wallet.toString()).toStringAsFixed(2)}", style: TextStyle(color:Colors.white,
                                       fontSize: 22),),
                                   Padding(
                                     padding: const EdgeInsets.only(top:8.0),
                                     child: ElevatedButton(
                                       style:  ButtonStyle(
                                           backgroundColor: MaterialStateProperty.all(Color(0xFF398248)),
                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                               RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(8.0),
                                               )
                                           )
                                       ),

                                       child: Container(
                                         width: 80,
                                         height: 30,
                                         alignment: Alignment.center,
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                         child: Text('Redeem'),
                                       ),
                                       onPressed: () {
                                         dialogConfirm();

                                       },
                                     ),
                                   ),
                                 ],
                               ),
                                Spacer(),
                                Container(
                                  height: 80,
                                  width: 0.9,
                                  child: DottedBorder(
                                    strokeWidth: 1,
                                      color: Colors.white,
                                      child: Text('')),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Total KG' ,style: TextStyle(color: Colors.white),),
                                    ),
                                    Text(double.parse(network.points.toString()).toStringAsFixed(1)+'KG',style: TextStyle(color:Colors.white,
    fontSize: 22),),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('My Points' ,style: TextStyle(color: Colors.white),),
                                    ),
                                    Text(double.parse(network.walletpoints.toString()).toStringAsFixed(2),style: TextStyle(color:Colors.white,
                                        fontSize: 18),),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top:6.0),
                                    //   child: TextButton(
                                    //     style:  ButtonStyle(
                                    //       padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    //         backgroundColor: MaterialStateProperty.all(Colors.white12),
                                    //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    //             RoundedRectangleBorder(
                                    //               borderRadius: BorderRadius.circular(8.0),
                                    //             )
                                    //         )
                                    //     ),
                                    //
                                    //     child: Container(
                                    //       width: 120,
                                    //       height: 37,
                                    //       alignment: Alignment.center,
                                    //       decoration: BoxDecoration(
                                    //           border: Border.all(color: Colors.white),
                                    //           borderRadius: BorderRadius.circular(8)),
                                    //       child: Text('Convert', style: TextStyle(color:  Colors.white,)),
                                    //     ),
                                    //     onPressed: () {
                                    //
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),




                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, right: 16),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return AgentMap();
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: DottedBorder(
                                color: Color(0xFF00A85A).withOpacity(0.5),
                                radius: Radius.circular(1),
                                strokeWidth: 20,
                                child: Container(
                                      height: 160,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE5F7EE),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/bin.png'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Recycle Waste'),
                                          )
                                        ],
                                      )),
                                ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:8.0, left: 16),
                          child: InkWell(
                            onTap: (){
                              print('call');
                              var datas = Provider.of<Utils>(context, listen: false);
                              datas.makeEmailCall('newmap@gmail.com');
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: DottedBorder(
                                color: Color(0xFF00A85A).withOpacity(0.5),
                                radius: Radius.circular(1),
                                strokeWidth: 20,
                                child: Container(
                                    height: 160,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE5F7EE),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/support.png'),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Help & Support'),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:16.0, bottom: 8, left:18),
                      child: Text('Recent Transactions', style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold),),
                    ),
                    Builder(
                        builder: (context) {
                          return transaction == null ? Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Theme(
                                  data: Theme.of(context).copyWith(
                                    accentColor: Color(0xFF00A85A),),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF00A85A)),
                                    strokeWidth: 2,
                                    backgroundColor: Colors.white,
                                    //  valueColor: new AlwaysStoppedAnimation<Color>(color: Color(0xFF9B049B)),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Loading',
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )) : transaction!.isEmpty ?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("No Transaction Available", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500)),),
                            ],
                          ) :


                          Container(
                            child: ListView.builder(
                                itemCount: transaction!.length<=0?0:transaction!.length<3?transaction!.length:3,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  transaction!.sort((a, b) => b.id!.compareTo(num.parse(a.id.toString())));

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 0),
                                              decoration: BoxDecoration(
                                                  color: index.isEven ? Color(0xFF00A85A)
                                                      .withOpacity(0.6) :
                                                  Color(0xFFC70D0D).withOpacity(0.6),
                                                  borderRadius: BorderRadius.circular(100)),
                                              height: 44,
                                              width: 44,
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      index.isEven ? Icons.arrow_upward : Icons
                                                          .arrow_downward_outlined,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left:10),
                                              child: Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.6,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Text('Your wallet have been credited',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Text(
                                                          '₦${transaction![index].vendoramount} was added to your account of a transaction of ₦${transaction![index].amount} ${transaction![index].category}'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),


                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Builder(
                                                    builder: (context) {
                                                      DateTime date = DateTime.parse("${transaction![index].created.toString()} ${transaction![index].createdtime.toString()}");
                                                      var result = Utils.formatTime(date);

                                                      return Padding(
                                                        padding: const EdgeInsets.only(right:8.0),
                                                        child: Text(result, style: TextStyle(
                                                            color: Color(0xFF141414).withOpacity(
                                                                0.47))),
                                                      );
                                                    }
                                                ),
                                                SizedBox(height: 40,),
                                                Container(
                                                  margin: const EdgeInsets.only(right:8.0),
                                                  child: Text(transaction![index].created.toString(), style: TextStyle(
                                                      color: Color(0xFF141414).withOpacity(
                                                          0.47)),),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                      // ↙
                                      Divider(),
                                    ],
                                  );
                                }),

                          );
                        })

                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }




  dialogConfirm() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>  AlertDialog(
        title: Text('Choose Redeem Method'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return BankDetails();
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
              child: Tab(
                child: Text('Cash'),
                icon: Icon(Icons.money),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            InkWell(
              onTap: ()async{
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return AirtimeDetails(bank: false, info: null, title: null,);
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
              child: Tab(
                child: Text('Airtime'),
                icon: Icon(Icons.credit_card),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            InkWell(
              onTap: ()async{
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return AirtimeDetails(bank: false, info: null, title: null,gift: true, );
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
              child: Tab(
                child: Text('Gift'),
                icon: Icon(Icons.wallet_giftcard_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }

}
