import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newmap/Model/Agents.dart';
import 'package:newmap/Model/Bank.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Service/Location.dart';
import 'package:newmap/Service/Network.dart';
import 'package:provider/provider.dart';

// class Data{
//   var Log;
//   var Lan;
//   var distance;
//   var businessName;
//   var profilePic;
//   var detail;
//   Data(this.Lan,this.Log,this.distance, this.detail, this.profilePic, this.businessName);
// }
//
// List data = [
//   Data('10.0','22.0',30, 'busnes1', 'assets/images/recycle.jpeg', 'details1'),
//   Data('10.3','21.21',21, 'busnes2', 'assets/images/recycle.jpeg', 'details2'),
//   Data('10.2', '22',42, 'busnes3', 'assets/images/recycle.jpeg', 'details3'),
//   Data('10.5','22.3',30, 'busnes4', 'assets/images/recycle.jpeg', 'details4'),
//   Data('10.3','21',8.30, 'busnes5', 'assets/images/recycle.jpeg', 'details5'),
// ];




class AgentMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AgentMapState();
  }
}

class _AgentMapState extends State<AgentMap> {
  // BitmapDescriptor custom_marker;
  // BitmapDescriptor custom_user_marker;



  var marker = Set<Marker>();
  var zoom_value ;
  var index_value;
  PageController ?_myPage;
  List<Agents> ?agents;

  callagent(context)async{
    var location = Provider.of<LocationService>(context, listen: false);
    var network = Provider.of<WebServices>(context, listen: false);
    network.getAgents(location.location_latitude.toString()
        ,location.location_longitude.toString()).then((value) {
      setState(() {
        agents = value ;
      });
      for (index_value in agents!) {
        marker.add(
            Marker(
                infoWindow: InfoWindow(title: '${index_value.fullname} Meters'),
                markerId: MarkerId(index_value.latitude.toString()),
                // icon: custom_marker,
                position: LatLng(double.parse(index_value.latitude),
                    double.parse(index_value.longitude))));
      }


    });
  }

  @override
  void initState() {
    super.initState();
    callagent(context);
    zoom_value = 15.0;
    _myPage =
        PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
    var location = Provider.of<LocationService>(context, listen: false);




    marker.add(Marker(
        markerId: MarkerId('current location'),
        // icon: custom_user_marker,
        position: LatLng(location.location_latitude,
            location.location_longitude)));
    // BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(
    //       size: Size(1.5, 1.5),
    //     ),
    //     'assets/images/truckmarkerBlue.png')
    //     .then((v) {
    //   custom_marker = v;
    // });
    //
    // BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(1.5, 1.5)),
    //     'assets/images/homemarkerBlue.png')
    //     .then((v) {
    //   custom_user_marker = v;
    // });

  }

  bool mybool = true;

  @override
  Widget build(BuildContext context) {
    var locationValues = Provider.of<LocationService>(context, listen: false);
    var utils = Provider.of<Utils>(context, listen: true);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFFCFFFD),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Agents', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
          centerTitle: true,
          actions: [
            Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Switch(
                      activeColor: Color(0xFF00A85A),
                      value: utils.list,
                      onChanged: (value){
                        //setState(() {
                        utils.setList(value);
                        //});

                        value?_myPage!.jumpToPage(1):_myPage!.jumpToPage(0);
                      }),
                  Text('List',style: TextStyle( color: Colors.black),),
                  SizedBox(width: 10,)
                ],
              ),
            )
          ],
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
              utils.setList(false);
            },
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black54, size: 18,),
          ),
        ),
        body: WillPopScope(
          onWillPop: ()async{
            Navigator.pop(context);
            utils.setList(false);
            return mybool;
          },
          child: agents==null?Center(child: Column(
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
          )):agents!.isEmpty?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("No Agents Available", style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  height: 1.4,
                  fontWeight: FontWeight.w500)),),
            ],
          ):agents![0].fullname=='network'?Container(
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
                    agents = null;
                    callagent(context);
                  });
                }, icon: Icon(Icons.refresh, color: Color(0xFF00A85A),),
                    label: Text('Refresh', style: TextStyle(color: Color(0xFF00A85A)),))
              ],
            ),),
          ):PageView(
    controller: _myPage,
    physics: NeverScrollableScrollPhysics(),
    children: [
    MapDetails(locationValues, context),
    ListDetails(locationValues, context)
    ],
    ),
        ));

      // FutureBuilder(
      //   future: webservices.get_all_vendor_current_location(
      //     context: context,
      //     location_latitude: locationValues.location_latitude,
      //     location_longtitude: locationValues.location_longitude,
      //     range_value: range_value,
      //   ),
      //   builder: (context, snapshots) {
      //     if (snapshots.hasData) {
      //       return MapDetails(snapshots, locationValues, context);
      //     } else if (snapshots.hasError) {
      //       return Text('${snapshots.error}');
      //     }
      //     return Center(child: CircularProgressIndicator());
      //   });
  }





  Widget ListDetails( locationValues, context){
    // var webservices = Provider.of<WebServices>(context, listen: false);
    var locationValues = Provider.of<LocationService>(context, listen: false);
    return ListView.builder(
        itemCount: agents!.length,
        itemBuilder: (context, index) {

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
              },
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                            backgroundImage: NetworkImage("https://frankediku.pythonanywhere.com/media/${agents![index].image.toString()}"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              agents![index].fullname.toString().capitalize(),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Text(
                                  "ID: ${agents![index].id.toString()}",
                                style: TextStyle(

                                    fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF00A85A).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(100)),
                          height: 47,
                          width: 47,
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (){
                                var datas = Provider.of<Utils>(context, listen: false);
                                datas.makePhoneCall(agents![index].phonenumber.toString());
                              },
                              icon: Icon(Icons.phone ,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFFCEE2D9)),
            color: Color(0xFFF2F4F3),
                    ),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top:11.0, left:3, right:3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.pin_drop_outlined, color: Colors.red,),
                              // Text(
                              //     agents![index].fullname.toString().capitalize(),
                              //   style: TextStyle(
                              //       fontWeight:
                              //       FontWeight.bold,
                              //       fontSize: 15),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:2.0),
                            child: Text(agents![index].address.toString().capitalize(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54), maxLines: 3, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                       top: 0.0,bottom:0, right:8
                      ),
                      child:  TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),),
                        onPressed: (){
                          var datas = Provider.of<Utils>(context, listen: false);
                          datas.makeOpenUrl(
                              'https://www.google.com/maps?saddr=${locationValues.location_latitude},${locationValues.location_longitude}&daddr= ${agents![index].latitude}, ${agents![index].longitude}');
                          print('direction');
                        },
                        child: Text('Get Direction',
                          style: TextStyle(color: Color(0xFF00A85A), fontSize: 15,decoration:  TextDecoration.underline,), ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:0.0),
                    child: Divider(),
                  ),
                ],
              ),
            ),
          );
        });
  }





  Widget MapDetails(locationValues, context) {
  //  var webservices = Provider.of<WebServices>(context, listen: false);
    var locationValues = Provider.of<LocationService>(context, listen: false);
    Completer<GoogleMapController> _controller  = Completer();
    return PageView.builder(
      itemCount: agents!.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
      //  marker.clear();

        return Stack(
          children: <Widget>[
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  zoom: zoom_value,
                  target: LatLng(locationValues.location_latitude,
                      locationValues.location_longitude),
                ),
                onMapCreated: (GoogleMapController controller) async {
                  _controller.complete(controller);
                },
                markers: marker,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 210,
                alignment: Alignment.bottomCenter,
                child: PageView.builder(
                    onPageChanged: (index) async {
                      GoogleMapController controller = await _controller.future;
                      return controller.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              bearing: 45,
                              tilt: 50,
                              zoom: zoom_value,
                              target: LatLng(
                                double.parse(agents![index].latitude.toString()),
                                double.parse(agents![index].longitude.toString()),
                              ))));
                    },
                    itemCount: agents!.length,
                    scrollDirection: Axis.horizontal,
                    controller: PageController(viewportFraction: 0.65),
                    itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10, right: 15),
                              child: InkWell(
                                onTap: () async {

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color:
                                          Colors.black54.withOpacity(0.1),
                                          blurRadius: 1,
                                          offset: Offset(5, 4),
                                        )
                                      ]),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width: 300,
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage("https://frankediku.pythonanywhere.com/media/${agents![index].image.toString()}"),
                                                fit: BoxFit.fill,
                                              ),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.blue
                                                      .withOpacity(.1)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: 300,
                                          height: 122,
                                          child: Text(''),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
                                            color: Color.fromARGB(218, 255, 255, 255),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(-1.4,1.0),
                                        child: Container(
                                          width: 120,
                                          height: 122,
                                          child: Text(''),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
                                            color: Color(0xFFa3e6b7),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        left: -4,
                                        top:-4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:  Color(0xFF00A85A,),
                                              border: Border.all(color: Colors.white24),
                                              borderRadius: BorderRadius.circular(100)),
                                          height: 50,
                                          width: 50,
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: (){
                                                print('call');
                                                var datas = Provider.of<Utils>(context, listen: false);
                                                datas.makePhoneCall(agents![index].phonenumber.toString());
                                              },
                                              icon: Icon(Icons.call ,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                       Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                           Container(
                                                //width: 200,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: Row(
                                                    crossAxisAlignment:CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:15.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                   agents![index].fullname.toString().capitalize(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 15),
                                                              softWrap: true,
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                            Container(
                                                              width: 200,
                                                              child: Text(
                                                                agents![index].address.toString().capitalize(),
                                                                style:
                                                                TextStyle(fontSize: 15.5, ),
                                                                softWrap: true,
                                                                overflow:
                                                                TextOverflow.ellipsis,
                                                                maxLines: 3,
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF00A85A).withOpacity(0.6),
                                                      borderRadius: BorderRadius.circular(100)),
                                                  height: 20,
                                                  width: 20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(0),
                                                    child: IconButton(
                                                      padding: EdgeInsets.all(0),
                                                      onPressed: (){},
                                                      icon: Icon(Icons.pin_drop_outlined ,
                                                          size: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),

                                                InkWell(
                                                    onTap: (){
                                                      var datas = Provider.of<Utils>(context, listen: false);
                                                      datas.makeOpenUrl(
                                                          'https://www.google.com/maps?saddr=${locationValues.location_latitude},${locationValues.location_longitude}&daddr= ${agents![index].latitude}, ${agents![index].longitude}');
                                                      print('direction');

                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text('Get Direction',
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12,decoration:  TextDecoration.underline,), ),
                                                    ),
                                                  ),
                                              ],
                                            ),

                                          ],

                                      ),



                                    ],
                                  ),
                                ),
                              ),
                            );


                    }),
              ),
            ),
          ],
        );
      },
    );
  }

}



