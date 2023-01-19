import 'package:event_planner/models/directions_model.dart';
import 'package:event_planner/repository/direction_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../../utils/text_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _MapScreenState extends State<MapScreen> {
  CameraPosition initialCameraPosition = CameraPosition(target: LatLng(5.9717, 80.6951),zoom: 11.5);

  late GoogleMapController googleMapController;
  Marker? origin;
  Marker? destination;
  Marker? liveLocation;
  Directions? _info;
  String? lat;
  String? lng;
  bool isLoading = true;

  @override
  void initState() {
    getCurrentLocation().then((value) {
      lat = value.latitude.toString();
      lng = value.longitude.toString();
      setState(() {
        print("lats: $lat");
        print("lngs: $lng");
        isLoading = false;
        if(lat != null && lng != null){
         // initialCameraPosition = CameraPosition(target: LatLng(double.parse(lat!), double.parse(lng!)),zoom: 11.5);
        }
      });

    });
    super.initState();
  }
  Future<Position> getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Location  Services are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        return Future.error("Location Permission are denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("Location Permission are denied forever. we cannot request");
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Center(child: CircularProgressIndicator(),):
    Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Text("Location"),
        backgroundColor: bgDark,
        actions: [
          TextButton(onPressed: (){
            if(origin != null)
            googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                    target: origin!.position,zoom: 14.5,tilt: 50.0)));

          },
              child: Text("Origin",style: appbarActionStyle,)),

          TextButton(onPressed: (){
           if (destination != null)
             googleMapController.animateCamera(
                 CameraUpdate.newCameraPosition(CameraPosition(
                     target: destination!.position,zoom: 14.5,tilt: 50.0)));
          },
              child: Text("Destination",style: appbarActionStyle,)),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bgDark,
        child: Icon(Icons.center_focus_strong_rounded),
        onPressed: () {
          googleMapController.animateCamera(
              _info != null ?
              CameraUpdate.newLatLngBounds(_info!.bounds, 100.0):
              CameraUpdate.newCameraPosition(initialCameraPosition));
        },
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (created)=> googleMapController = created,
            markers: {
              if (origin != null) origin!,
              if (destination != null) destination!
            },
            onLongPress: addMarker,
            polylines: {
              if(_info != null)
                Polyline(polylineId: PolylineId("overview_polyline"),color: Colors.black,width: 4,
                    points: _info!.polyLinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList()),
            },
          ),
          if(_info != null)
            Positioned(
              top: 100,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color: Colors.black,
                      offset: Offset(0,2),
                      blurRadius: 10.0

                    )]
                    
                  ),

                  child: Text("${_info!.totalDistance}    ${_info!.totalDuration}"),
                )),
          if(_info != null)
            Positioned(
                bottom: 20,
                child: Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Location added successfully"),
                        ));
                        Navigator.pop(context);

                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: bgDark)
                        ),
                        primary: bgDark,
                        elevation: 8,
                        shadowColor: Colors.black87,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          StringValues.lblSaveLocation,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    )),),
          Positioned(
            top: 10,
            child: Container(
                width: MediaQuery.of(context).size.width*0.4,
                child: ElevatedButton(
                  onPressed: () async {
                    Prediction? p = await PlacesAutocomplete.show(context: context,
                        apiKey: "",
                        //onError: onError,
                        mode: Mode.overlay,
                      language: "en",
                      strictbounds: false,
                      components: [Component(Component.country, "pk")]
                    );

                    GoogleMapsPlaces places = GoogleMapsPlaces(
                      apiKey: "",
                      apiHeaders: await const GoogleApiHeaders().getHeaders()
                    );

                    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p!.placeId!);

                    final lat = detail.result.geometry!.location.lat;
                    final lng = detail.result.geometry!.location.lng;

                    origin = Marker(markerId: MarkerId("origin"),
                        infoWindow: InfoWindow(title: "Origin"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                        position: LatLng(lat,lng)
                    );
                    setState(() {

                    });

                    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat,lng), 14.0));



                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: bgDark)
                    ),
                    primary: bgDark,
                    elevation: 8,
                    shadowColor: Colors.black87,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      StringValues.lblSearchLocation,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                )),),
        ],
      ),
    );
  }
  Future<void> addMarker (LatLng pos) async {
    if(origin == null || (origin != null && destination != null)){
     setState(() {
       origin = Marker(markerId: MarkerId("origin"),
           infoWindow: InfoWindow(title: "Origin"),
           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
           position: pos
       );
       destination = null;
       _info = null;
     });
    } else {
      setState(() {
        destination = Marker(markerId: MarkerId("destination"),
            infoWindow: InfoWindow(title: "Destination"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos
        );
      });
      final directions = await DirectionRepository().getDirections(origin: origin!.position, destination: pos);
      setState(() {
        _info = directions;
      });

    }

  }
}
