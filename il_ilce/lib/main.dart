import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:il_ilceler/il.dart';
import 'package:il_ilceler/ilce.dart';
void main(){
  runApp(MaterialApp(home: MyWidget(),));
}
class MyWidget extends StatefulWidget {

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Il>iller=[];

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
       jsonCozumle();
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ogeler(context, index);
      },itemCount: iller.length,),
    );
  }

  void jsonCozumle()async{
    String jsonString = await rootBundle.loadString("assets/il_ilceler.json");
    Map<String, dynamic> illermap= jsonDecode(jsonString);
    for(String sira in illermap.keys){
      Map<String, dynamic> ilmap = illermap[sira];
      String ilname=ilmap["name"];
      int population=ilmap["population"];
      Map<String , dynamic> ilcelermap = ilmap["districts"];
      List<Ilce> tumilceler =[];
      for(String ilcekodu in ilcelermap.keys){
        Map<String , dynamic> ilceMap= ilcelermap[ilcekodu];
        String ilceismi = ilceMap["name"];
        Ilce ilce=Ilce(name: ilceismi);
        tumilceler.add(ilce);
      }
      Il il =Il(name: ilname,sira: sira,districts: tumilceler,population: population);
      iller.add(il);
      


    }
    setState(() {
      
    });
  }
Widget ogeler(BuildContext context, int index) {
  return Card(
    child: ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(iller[index].name.toString()),
          Text(iller[index].sira.toString())
        ],
      ),
      subtitle: Text("Nüfus : ${iller[index].population}"),
      // Trailing kısmında sira bilgisi kullanılacaksa, Il sınıfına sira ekleyin.
      // Eğer sira bilgisi gerekliyse, bu alanı tanımlayıp kullanın
      // trailing: Text(iller[index].sira ?? ""),
      children: iller[index].districts!.map((ilce) {
        return ListTile(
          title: Text(ilce.name.toString()),
        );
      }).toList(),
    ),
  );
}

}