import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiitr/my_drawer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:iiitr/screen_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusSchedule extends StatefulWidget {
  static const String id = 'BusSchedule';

  @override
  _BusScheduleState createState() => _BusScheduleState();
}

class _BusScheduleState extends State<BusSchedule> {
  var fromIITH = [];
  var toIITH = [];
  var fromIITHWeekend = [];
  var toIITHWeekend = [];

  final Set<Polyline> _polylines = Set();
  final Set<Marker> _markers = Set();

  LatLng _point1;

  LatLng _point2;

  final LatLng _iITHCord = LatLng(17.596773, 78.125223);
  final LatLng _lingampallyCord = LatLng(17.496142, 78.315077);
  final LatLng _sangareddyCord = LatLng(17.588030, 78.083910);
  final LatLng _maingateCord = LatLng(17.580265, 78.121158);

  GoogleMapController _controller;

  LatLng selectedRoute(String selectedLoc) {
    if (selectedLoc == 'Lingampally') {
      return _lingampallyCord;
    } else if (selectedLoc == 'Sangareddy') {
      return _sangareddyCord;
    } else if (selectedLoc == 'Main Gate') {
      return _maingateCord;
    } else {
      return LatLng(0, 0);
    }
  }

  void prepareMarkers() {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_point1.toString()),
      //_lastMapPosition is any coordinate which should be your default
      //position when map opens up
      position: _point1,
      icon: BitmapDescriptor.defaultMarker,
    ));

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_point2.toString()),
      //_lastMapPosition is any coordinate which should be your default
      //position when map opens up
      position: _point2,
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  LatLng suitableCentre(LatLng x) {
    if (x == _lingampallyCord) {
      return LatLng(17.545863, 78.204044);
    } else if (x == _sangareddyCord) {
      return LatLng(17.589231, 78.103419);
    } else if (x == _maingateCord) {
      return LatLng(17.586231, 78.120664);
    } else {
      return LatLng(0, 0);
    }
  }

  double suitableZoom(LatLng y) {
    if (y == _lingampallyCord) {
      return 11;
    } else if (y == _sangareddyCord) {
      return 13.35;
    } else if (y == _maingateCord) {
      return 14.5;
    } else {
      return 0;
    }
  }

  String distTimCar(LatLng z) {
    if (z == _lingampallyCord) {
      return "27 km in 37 min";
    } else if (z == _sangareddyCord) {
      return "8.6 km in 18 min";
    } else if (z == _maingateCord) {
      return "3.4 km in 9 min";
    } else {
      return "error";
    }
  }

  String distTimWalk(LatLng a) {
    if (a == _lingampallyCord) {
      return "25.4 km in 5 h 9 min";
    } else if (a == _sangareddyCord) {
      return "6.5 km in 1 h 18 min";
    } else if (a == _maingateCord) {
      return "2.5 km in 30 min";
    } else {
      return "error";
    }
  }

  int r = 0;

  List fromORto(int j, r) {
    if (j == 0 && r == 0) {
      return fromIITH;
    } else if (j == 0 && r == 1) {
      return fromIITHWeekend;
    } else if (j == 1 && r == 0) {
      return toIITH;
    } else if (j == 1 && r == 1) {
      return toIITHWeekend;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  QuerySnapshot cache;

  @override
  Widget build(BuildContext context) {
    _point1 = _iITHCord;

    final BusRouteScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    _point2 = selectedRoute('${args.selectedRoute}');

    String routeHeading(index) {
      if (index == 0) {
        return "IITH to ${args.selectedRoute}";
      } else if (index == 1) {
        return "${args.selectedRoute} to IITH";
      } else {
        return "error";
      }
    }

    _polylines.add(Polyline(
      polylineId: PolylineId("line 1"),
      visible: true,
      width: 5,
      //latlng is List<LatLng>
      patterns: [PatternItem.dash(30), PatternItem.gap(10)],
      points: MapsCurvedLines.getPointsOnCurve(_point1, _point2),
      // Invoke lib to get curved line points
      color: Colors.blue,
    ));

    prepareMarkers();

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: new Text(
          "Bus Schedule",
          style: TextStyle(fontSize: 25.0),
        ),
        // backgroundColor:Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ToggleSwitch(
                minWidth: 90.0,
                initialLabelIndex: 0,
                activeBgColor: Colors.indigo,
                activeTextColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveTextColor: Colors.grey[900],
                labels: ['WeekDay', 'WeekEnd'],
                onToggle: (index) {
                  r = index;
                  print('switched to: $index');
                  (context as Element).reassemble();
                },
              ),
              SizedBox(width: 20.0),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: PageView.builder(
                itemCount: 2,
                itemBuilder: (_, i) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                routeHeading(i),
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            initialData: cache,
                            stream: Firestore.instance
                                .collection('Bus Schedule')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              cache = snapshot.data;

                              var cityRoutes = snapshot.data.documents;

                              for (var cityRoute in cityRoutes) {
                                if (cityRoute.documentID ==
                                    '${args.selectedRoute}') {
                                  fromIITH = cityRoute['from IITH'];
                                  toIITH = cityRoute['to IITH'];
                                  fromIITHWeekend =
                                      cityRoute['from IITH weekend'];
                                  toIITHWeekend = cityRoute['to IITH weekend'];
                                }
                              }

//
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(4.0),
                                      itemCount: fromORto(i, r).length,
                                      itemBuilder: (_, p) {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            height: 35,
                                            color: Colors.black54,
                                            child: Center(
                                                child: Text(
                                              '${fromORto(i, r)[p]}',
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            })
                      ],
                    ),
                    color: Colors.white12,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.98,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: GoogleMap(
                  scrollGesturesEnabled: false,
                  liteModeEnabled: false,
                  rotateGesturesEnabled: false,
                  polylines: _polylines,
                  markers: _markers,
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: suitableCentre(_point2),
                      zoom: suitableZoom(_point2),
                      tilt: 90),
                  mapType: MapType.normal,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.99,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.directions_car),
                      Text(
                        distTimCar(_point2),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.directions_walk),
                      Text(
                        distTimWalk(_point2),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
              color: Colors.white12,
            ),
          ),
        ],
      ),
    );
  }
}
