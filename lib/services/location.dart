import 'package:geolocator/geolocator.dart';

class Location {
  double? latidude;
  double? longtude;
  Future getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latidude = position.latitude;
      longtude = position.longitude;
      //  print(position);
    } catch (e) {}
  }
}
