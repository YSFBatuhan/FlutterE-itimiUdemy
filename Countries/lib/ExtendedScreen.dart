import 'package:flutter/material.dart';
import 'package:world_countries/country_model.dart';

class Extended extends StatelessWidget {
  final Country country; // Use final for immutable properties

  Extended({required this.country});
  var style=TextStyle(color: Colors.black,fontSize: 30); 

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(country.countryName ?? 'Country Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
          children: [
            Center(
              child: Container(
                height: 200,
                width: width - 40, // Width minus padding
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(country.countryFlag ?? ''),
                    fit: BoxFit.cover, // Cover the container
                  ),
                  borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(country.countryName ?? 'No Name',style: style,),
                SizedBox(width: 20),
                Text(country.countryCode ?? 'No Code',style: style),
              ],
            ),
            Divider(
              indent: 30,
              endIndent: 30,
            ),
            SizedBox(height: 10), // Add some spacing between items
            Text("Official Name: ${country.countryOfficialName ?? 'N/A'},style: style"),
            SizedBox(height: 10),
            Text("Language: ${country.languages ?? 'N/A'},style: style"),
            SizedBox(height: 10),
            Text("Capital: ${country.capitals ?? 'N/A'},style: style"),
            SizedBox(height: 10),
            Text("Population: ${country.population ?? 'N/A'},style: style"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(country.countryCurrencies ?? 'N/A',style: style),
                VerticalDivider(
                  thickness: 2, // Adjust thickness for better visibility
                  color: Colors.blue,
                  width: 20,
                ),
                Text(country.countryCurrenciesName ?? 'N/A',style: style),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
