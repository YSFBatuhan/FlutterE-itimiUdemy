import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_countries/ExtendedScreen.dart';
import 'package:world_countries/country_model.dart';
import 'package:world_countries/favoritesScreen.dart';
import 'package:world_countries/main.dart';
import 'package:world_countries/ortak_liste.dart';

List<Country> allCountries = [];
List<String> favoriteCountries = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        favorileriHafizadanCek().then((value) {
          getInfo();
        },);
      
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("deneme"),actions: [IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Favorites(allCountries: allCountries,favoriteCountries: favoriteCountries,),)); 
        }, icon: Icon(Icons.favorite_sharp,color: Colors.red,))],
      ),
      body: _isLoading ? OrtakListe(Countries: allCountries,favoriteCountries: favoriteCountries,) : CircularProgressIndicator(),
    );
  }

  void getInfo() async {
    Uri uri = Uri.parse(apiKey);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body);
    for (int i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> ulkeMap = parsedResponse[i];
      Country country = Country.mapOlustur(ulkeMap);
      allCountries.add(country);
    }
    setState(() {
      _isLoading = true;
    });
  }
     
  Future<void> favorileriHafizadanCek()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriler = prefs.getStringList("favoriler");
    if(favoriler!=null){
      for(String ulkeKodu in favoriler){
        favoriteCountries.add(ulkeKodu);
      }
    }
  }


}

