import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Tap1 extends StatefulWidget {
  @override
  _Tap1State createState() => _Tap1State();
}

class _Tap1State extends State<Tap1> {
  double lat, long;
  Address first;
  TextEditingController _address = TextEditingController();

  Future<Null> get_addres_now() async {
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses.first;
    });
    print(first.addressLine);
  }

  Future<Null> get_address_find()async{
    var addresses = await Geocoder.local.findAddressesFromQuery(_address.text);
    setState(() {
      first = addresses.first;
    });
  }


  Future<Null> getlat_long() async {
    LocationData locationData = await getlocation();
    setState(() {
      lat = locationData.latitude;
      long = locationData.longitude;
    });
    get_addres_now();
    print('lat = ${lat} , long = $long');
  }

  Future<LocationData> getlocation() {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {}
  }

  @override
  void initState() {
    getlat_long();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: _address,
                  decoration:
                      InputDecoration(labelText: 'กรอกที่อยู่', filled: true),
                ),
              ),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  get_address_find();
                },
                child: Text('ค้นหา'),
                color: Colors.pinkAccent,
                textColor: Colors.white,
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        first == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('ที่อยู่ปัจุบันของคุณคือ : ')],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ที่อยู่ปัจุบันของคุณคือ : ')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ตำบล : ${first.locality}')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('อำเภอ : ${first.subAdminArea}')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('จังหวัด : ${first.adminArea}')
                    ],
                  ),
                ],
              ),
        SizedBox(
          height: 15,
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              lat = first.coordinates.latitude;
              long = first.coordinates.longitude;
            });
            MapsLauncher.launchCoordinates(lat, long);
          },
          child: Text('ไปกันเลย'),
          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
