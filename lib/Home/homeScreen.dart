import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:openweather/constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationData? _currentPosition;
  String? _address, _dateTime;
  Location location = Location();
  String datetime = DateTime.now().toString();
  TextEditingController cityController = TextEditingController();
  bool isLoading = false;

// 2021-08-27 19:14:57.142575

  // LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  String city = "";
  String country = "";
  String longitude = "";
  String latitude = "";
  String etat = "";
  String mint = "";
  String maxt = "";
  String windSp = "";
  String windDeg = "";
  String humidity = "";

  int icon = 0;

  @override
  void initState() {
    super.initState();

    getLocation();
  }

  Future<void> getWeatherDataByLocation(double? lat, double? lon) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=c00b8fa946e678e93605b7ebc959ab4c"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      double lon = data['coord']['lon'];
      double lat = data['coord']['lat'];
      List<dynamic> weather = data['weather'];
      double tempMin = data['main']['temp_min'];
      double tempMax = data['main']['temp_max'];
      double humid = data['main']['humidity'];
      print("Success");
      setState(() {
        city = data['name'];
        country = data['sys']['country'];
        longitude = lon.toString();
        latitude = lat.toString();
        etat = weather[0]["description"];
        mint = tempMin.toString();
        maxt = tempMax.toString();
        icon = int.parse("0xf" + weather[0]["icon"]);
        windSp = data['wind']['speed'].toString();
        windDeg = data['wind']['deg'].toString();
        humidity = humid.toString();
      });
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<void> getWeatherDataByCity(String cityName) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=c00b8fa946e678e93605b7ebc959ab4c"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      double lon = data['coord']['lon'];
      double lat = data['coord']['lat'];
      List<dynamic> weather = data['weather'];
      double tempMin = data['main']['temp_min'];
      double tempMax = data['main']['temp_max'];
      print("Success");
      setState(() {
        city = data['name'];
        country = data['sys']['country'];
        longitude = lon.toString();
        latitude = lat.toString();
        etat = weather[0]["description"];
        mint = tempMin.toString();
        maxt = tempMax.toString();
        icon = int.parse("0xf" + weather[0]["icon"]);
        windSp = data['wind']['speed'].toString();
        windDeg = data['wind']['deg'].toString();
      });
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Invalid City Name'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: const Text("Weather Now"),
        leading: const Icon(Icons.dehaze_outlined),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: cityController,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(15),
                              width: 18,
                              child: const Icon(
                                Icons.search,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 50,
                          child: const Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {
                          (cityController.text.toString().isEmpty ||
                                  cityController.text.toString().length < 3)
                              ? showToast(context)
                              : getWeatherDataByCity(
                                  cityController.text.toString());
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Container(
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(
                left: 20,
                top: 35,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Ville :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 2),
                        SizedBox(
                          width: 110,
                          child: Text(
                            city,
                            style: const TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        const Text(
                          ",  Pays :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 2),
                        Text(
                          country,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding * 1.5),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Longitude :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 2),
                        Text(
                          longitude,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        const Text(
                          ",  Latitude :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 2),
                        Text(
                          latitude,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Container(
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(
                left: 20,
                top: 35,
              ),
              child: Row(
                children: [
                  const SizedBox(width: kDefaultPadding / 2),
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: kDefaultPadding * 1.3),
                      Icon(
                        IconData(0xf + icon, fontFamily: 'MaterialIcons'),
                      ),
                    ],
                  ),
                  const SizedBox(width: kDefaultPadding * 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            datetime,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Min : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            mint,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            " , Max : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            maxt,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Etat :  ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            etat,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Container(
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(
                left: 20,
                top: 35,
              ),
              child: Row(
                children: [
                  const SizedBox(width: kDefaultPadding / 2),
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: kDefaultPadding * 1.3),
                      const Icon(Icons.wind_power_outlined),
                    ],
                  ),
                  const SizedBox(width: kDefaultPadding * 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Wind Speed : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            windSp,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            " , Deg : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            windDeg,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Temp : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            mint,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Humidity : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            maxt,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    // _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    location.onLocationChanged.listen(
      (LocationData currentLocation) {
        print("${currentLocation.longitude} : ${currentLocation.longitude}");
        setState(
          () {
            _currentPosition = currentLocation;
            //   _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);

            //   DateTime now = DateTime.now();
            //   _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
            // _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            //     .then((value) {
            //   setState(() {
            //     _address = "${value.first.addressLine}";
            //   });
            // });

            getWeatherDataByLocation(
                _currentPosition?.latitude, _currentPosition?.longitude);
          },
        );
      },
    );
  }
}
