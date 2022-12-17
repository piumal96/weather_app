import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import '../utilities/constraints.dart';

class LocationScreen extends StatefulWidget {

  final locationWeather;
  LocationScreen({ this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int? temp;
  int? condition;
  String? cityName;
  String? icon;
  String? message;

  WeatherModel weatherModel=WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.locationWeather);

  }

  void updateUi(dynamic weatherData)async{
    setState(() {

      if(weatherData==null){

      }
      double temp1 = weatherData['main']['temp'];
      temp = temp1.toInt();
      cityName = weatherData['name'];
      var condition=weatherData['weather'][0]['id'];
      icon=weatherModel.getWeatherIcon(condition);
      message=weatherModel.getMessage(temp!);
      print(temp);
      print(cityName);
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: ()async {
                    var weatherData= await weatherModel.getLocationWeather();
                    updateUi(weatherData);

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                     var typeName= await Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen()));
                    if(typeName !=null){
                     var weatherData= await weatherModel.getCityWeather(typeName);
                     updateUi(weatherData);
                    }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                     '$temp °C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName ',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
