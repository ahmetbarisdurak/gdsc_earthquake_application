import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_solution_challenge/services/sos_mobile_service.dart';
import 'package:google_solution_challenge/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SosRev extends StatefulWidget {
  const SosRev({super.key});

  @override
  State<SosRev> createState() => _SosRevState();
}


class _SosRevState extends State<SosRev> {

  static double? _latitude;
  static double? _longitude;
  static LatLng? last_latLng;
  final SosMobileService _reportService = SosMobileService();
  var currentLocation;
  late bool serviceEnabled;
  late LocationPermission permission;
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String name = "";
  String surname = "";


  FirebaseDocument() async {
    var document = await db.collection('Person').doc(user.uid).get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      name = value!['name'];
      surname = value['surname'];
      print(name);
    });
  }  

  void SOSsent() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(148, 233, 125, 71),
          title: Text(
            LocaleKeys.Profile_sosMobile_sosCall.tr(),
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      }
    );
  }

  void warnmes(BuildContext context,latitude,longitude) {
    FirebaseDocument();
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(LocaleKeys.Profile_sosMobile_Cancel.tr(), style: const TextStyle(color: Colors.white, fontSize: 24),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();    
      },
    );
    Widget continueButton = TextButton(
      child: Text(LocaleKeys.Profile_sosMobile_Continue.tr(), style: const TextStyle(color: Colors.white, fontSize: 24),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();   
        SendSosMessage(latitude,longitude);
        Navigator.pop(context);
        
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color.fromARGB(237, 233, 125, 71),
      content: SizedBox(
        width: MediaQuery.of(context).size.width-20,
        height: MediaQuery.of(context).size.height/8,),
      title: Text(
        LocaleKeys.Profile_sosMobile_AreuSure.tr(),
        style: const TextStyle(color: Colors.white, fontSize: 24),
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }


  Future<void> SendSosMessage(latitude,longitude) async {
    FirebaseDocument();
  
    _reportService
        .addStatus("Help Me Please!!", 
                  ("$name $surname"),
                  GeoPoint(latitude, longitude),
        ).then((value) {
          SOSsent();
    });
  
  }

  Future<Position> _getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error(LocaleKeys.Profile_sosMobile_locationDisable.tr());
    }
    LocationPermission permission =await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission= await Geolocator.requestPermission();
      if (permission==LocationPermission.denied){
        return Future.error(LocaleKeys.Profile_sosMobile_locationDisable.tr());
      }
    }
    if(permission==LocationPermission.deniedForever){
      return Future.error(LocaleKeys.Profile_sosMobile_locationDisablePer.tr());
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(LocaleKeys.Profile_sosMobile_sosButton.tr(),style: const TextStyle(color: Color(0xffe97d47)),),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffe97d47),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context, 
                    builder: (context)=> SimpleDialog(
                      title: Text(LocaleKeys.Profile_sosMobile_sosButton.tr()),
                      contentPadding: const EdgeInsets.all(20.0),
                      children: [
                        Text(LocaleKeys.Profile_sosMobile_info.tr()),
                        TextButton(
                          onPressed:() {
                            Navigator.of(context).pop();
                          }, 
                          child: Text(LocaleKeys.Profile_sosMobile_Close.tr(), style: const TextStyle(color:Color(0xffe97d47) ),),
                        )
                      ],

                    )
                  );
                },
                child: const Icon(
                  Icons.info_outline,
                  color: Color(0xffe97d47),
                ),
              ),
            )
          ],
      ),
    body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Align(
                 alignment: Alignment.topCenter,
                    child: Text(LocaleKeys.Profile_sosMobile_SOS.tr(),style: const TextStyle(fontSize: 96, fontWeight: FontWeight.bold,fontFamily:'Nunito Sans' ,color: Color.fromARGB(255, 217, 0, 0) ),
                  ),
                    
                 
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60*MediaQuery.of(context).size.width),
                  color: const Color.fromARGB(255, 255, 171, 171),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(62, 0, 0, 0),
                      offset: Offset(4, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60*MediaQuery.of(context).size.width*4/5),
                            color: const Color.fromARGB(255, 251, 100, 100),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(62, 0, 0, 0),
                                offset: Offset(4, 4),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60*MediaQuery.of(context).size.width),
                                      color: const Color.fromARGB(255, 217, 0, 0),
                                      image: const DecorationImage(
                                        image: AssetImage("assets/images/ring_white.png"),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(62, 0, 0, 0),
                                          offset: Offset(4, 4),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: 
                                    GestureDetector(
                                      onTap: () {
                                        _getCurrentLocation().then((value) {
                                          setState(() {
                                            _latitude=value.latitude;
                                            _longitude=value.longitude;
                                            print(_latitude);
                                            //last_latLng=LatLng(_latitude, _longitude);
                                          });
                                        },);
                                        //print(last_latLng);
                                        FirebaseDocument();
                                        warnmes(context,_latitude,_longitude);
                                      },
                                    ),
                                        ),
                          ),),
                ),),
              const SizedBox(
                height: 30,
              ),
              Align(
                 alignment: Alignment.bottomCenter,
                    child: Text(LocaleKeys.Profile_sosMobile_emergency.tr(),textAlign: TextAlign.center, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold,fontFamily:'Nunito Sans' ),
                  ),
                    
                 
              )
            ],
          ),
        ),
      ),
    );
  }
}