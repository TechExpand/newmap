import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmap/Provider/BankProvider.dart';
import 'package:newmap/Provider/Provider.dart';
import 'package:newmap/Screen/SplashScreen.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Service/Location.dart';
import 'package:newmap/Service/Network.dart';
import 'package:provider/provider.dart';

import 'Provider/LGAProvider.dart';


void main()async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  // getfireBase()async{
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   Provider.debugCheckInvalidValueType = null;
  // }
  // getfireBase();
  await GetStorage.init();
  runApp(
      MultiProvider(providers: [
    ChangeNotifierProvider<Utils>(
      create: (context) => Utils(),
    ),
        ChangeNotifierProvider<LgaProvider>(
          create: (context) => LgaProvider(),
        ),
    ChangeNotifierProvider<LocationService>(
      create: (context) => LocationService(),
    ),
    ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
    ),
        ChangeNotifierProvider<BankProvider>(
          create: (context) => BankProvider(),
        ),
        ChangeNotifierProvider<WebServices>(
          create: (context) => WebServices(),
        ),

  ], child: MyApp())); // MyApp(widget)));


}

class MyApp extends StatefulWidget {

  @override
  MyAppState createState() => MyAppState();
}




class MyAppState extends State{
  void initState(){
    super.initState();
    Provider.of<LocationService>(context, listen: false).onlocation();
    Provider.of<BankProvider>(context, listen: false).getAllBank();
    Provider.of<WebServices>(context, listen: false).getLGA(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFF00A85A),
      title: 'NEWMAP',
      theme: ThemeData(
        accentColor: Colors.white10,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
    );
  }












}
