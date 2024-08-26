import 'package:flutter/material.dart';
import 'package:world_countries/anasayfa.dart';
import 'package:world_countries/country_model.dart';
import 'package:world_countries/ortak_liste.dart';

class Favorites extends StatefulWidget {
  final List<String> favoriteCountries;
  final List<Country> allCountries; // Make sure to pass the full list of countries

  Favorites({super.key, required this.favoriteCountries, required this.allCountries});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late List<Country> favorilerBurada=[];

  @override
  void initState() {
    super.initState();
    for(Country country in allCountries){
      if(widget.favoriteCountries.contains(country.countryCode)){
        favorilerBurada.add(country);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Favoriler"),
      ),
      body: OrtakListe(
        Countries: favorilerBurada,
        favoriteCountries: widget.favoriteCountries,
      ),
    );
  }
}
