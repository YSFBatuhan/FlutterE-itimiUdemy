import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_countries/ExtendedScreen.dart';
import 'package:world_countries/country_model.dart';

class OrtakListe extends StatefulWidget {
  final List<Country> Countries;
  final List<String> favoriteCountries;

  OrtakListe({
    required this.Countries,
    required this.favoriteCountries,
  });

  @override
  State<OrtakListe> createState() => _OrtakListeState();
}

class _OrtakListeState extends State<OrtakListe> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.Countries.length,
      itemBuilder: (context, index) {
        Country country = widget.Countries[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Extended(
                  country: country,
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(country.countryName!),
            trailing: IconButton(
              onPressed: () {
                addFavorite(country);
              },
              icon: Icon(
                widget.favoriteCountries.contains(country.countryCode!)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            subtitle: Text("Capital: ${country.capitals}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(country.countryFlag!),
            ),
          ),
        );
      },
    );
  }

  void addFavorite(Country country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedFavorites = List.from(widget.favoriteCountries);
    
    if (updatedFavorites.contains(country.countryCode)) {
      updatedFavorites.remove(country.countryCode);
    } else {
      updatedFavorites.add(country.countryCode!);
    }

    await prefs.setStringList("favoriler", updatedFavorites);

    setState(() {
      // Update the local state to reflect the changes
      widget.favoriteCountries.clear();
      widget.favoriteCountries.addAll(updatedFavorites);
      print(widget.favoriteCountries);
    });
  }
}
