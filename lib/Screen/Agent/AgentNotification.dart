import 'package:flutter/material.dart';
import 'package:newmap/Model/Transaction.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Service/Network.dart';
import 'package:provider/provider.dart';

class AgentNotificationPage extends StatefulWidget {


  @override
  AgentNotificationPageState createState() => AgentNotificationPageState();
}

class AgentNotificationPageState extends State<AgentNotificationPage> {

  List<Transaction> ?transaction;



  calltransaction(context)async{
    var network = Provider.of<WebServices>(context, listen: false);
    network.getVendorTransaction().then((value) {
      setState(() {
        transaction = value ;
      });
    });
  }


  @override
  void initState(){
    super.initState();
    calltransaction(context);
    // plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCFFFD),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Notification', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black54, size: 18,),
          ),
        ),
        body: Builder(
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
              ) :transaction![0].amount=='network'?Container(
                child:   Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("No Network Available", style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        height: 1.4,
                        fontWeight: FontWeight.w500)),
                    TextButton.icon(onPressed: (){
                      setState(() {
                        transaction = null;
                        calltransaction(context);
                      });
                    }, icon: Icon(Icons.refresh, color: Color(0xFF00A85A),),
                        label: Text('Refresh', style: TextStyle(color: Color(0xFF00A85A)),))
                  ],
                ),),
              ):




              Container(
                child: ListView.builder(
                    itemCount: transaction!.length,
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
            }));
  }
}
