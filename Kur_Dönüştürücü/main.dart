import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: MyWidget()));
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final String _apiKey = "09684ef1e6d18a94a2d183155d2da3c9";

  final String _baseUrl =
      "http://api.exchangeratesapi.io/v1/latest?access_key=";

  Map<String, double> liste = {};

  String _selectedCurrency = "AED";
  double sonuc = 0.0;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inttenvericek();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kur Dönüştürücü"),
        centerTitle: true,
      ),
      body: liste.isNotEmpty ? anaekran(context) : Center(child: CircularProgressIndicator())
      // anaekran(context)
    );
  }


  Widget anaekran(BuildContext context){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter amount',
                    ),
                    onChanged: (String yenideger) => hesapla(),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                DropdownButton<String>(
                  value: _selectedCurrency,
                  items: liste.keys.map((String kur) {
                    return DropdownMenuItem<String>(
                        child: Text(kur), value: kur);
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCurrency = newValue;
                        hesapla();
                      });
                    }
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Expanded(child: Text("USD  :  ${liste["USD"]?.toStringAsFixed(5)}")),Expanded(child: Text("EUR  :  ${liste["EUR"]?.toStringAsFixed(5)}")),],
              ),
            ),
            Text(
              sonuc.toStringAsFixed(2)+ "₺",
              style: TextStyle(fontSize: 40),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: liste.keys.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(liste.keys.toList()[index].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          liste.values.toList()[index].toStringAsFixed(5),
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("₺")
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
  }
  void hesapla() {
    double? result = double.tryParse(controller.text);
    double? rate = double.tryParse(liste[_selectedCurrency].toString());
    if (result != null && rate != null) {
      setState(() {
        sonuc = (result * rate);
      });
    }
  }

  void _inttenvericek() async {
    await Future.delayed(Duration(seconds: 2));
    Uri uri = Uri.parse(_baseUrl + _apiKey);
    http.Response response = await http.get(uri);
    Map<String, dynamic> parsedResponse = jsonDecode(response.body);
    Map<String, dynamic> rates = parsedResponse["rates"];

    double? basetlkuru = rates["TRY"];
    if (basetlkuru != null) {
      for (String ulkekuru in rates.keys) {
        double? basekur = double.tryParse(rates[ulkekuru].toString());
        if (basekur != null) {
          double? tlkuru = basetlkuru / basekur;
          liste[ulkekuru] = tlkuru;
        }
      }
    }
    setState(() {});
  }
}
