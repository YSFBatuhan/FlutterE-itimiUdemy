import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Mywidget(),));
}
class Mywidget extends StatefulWidget {

  @override
  State<Mywidget> createState() => _MywidgetState();
}

class _MywidgetState extends State<Mywidget> {
  TextEditingController _boy=TextEditingController();
  TextEditingController _kilo=TextEditingController();

  double sonuc=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vücut-Kitle Endeksi",style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(sonuc.toStringAsFixed(2),style: TextStyle(fontSize: 48,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(maxLength: 3,controller: _boy,decoration: InputDecoration(helperText: "Boyunuzu santimetre olarak giriniz",helperStyle: TextStyle(color: Colors.grey.shade500),hintText:"1.72",suffixText: "cm",label: Text("Boyunuz"),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(maxLength: 3,controller: _kilo,decoration: InputDecoration(helperText: "Kilonuzu doğru giriniz",helperStyle: TextStyle(color: Colors.grey.shade500),hintText:"68",suffixText: "kg",label: Text("Kilonuz"),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
            ),
            TextButton(onPressed: () => hesapla(), child: Text("Hesapla")),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network("https://www.koruhastanesi.com/images/vucut-kitle-indeksi-hesaplama.jpg"),
            ),
          ],
        ),
      ),
    );
  }
  void hesapla(){
    double boy=double.parse(_boy.text);
    double kilo=double.parse(_kilo.text);
    boy=boy/100;

    setState(() {
      try{
        sonuc=kilo/(boy*boy);

      }catch(e){
        print("sorun var");
      }
    });
  }
}

