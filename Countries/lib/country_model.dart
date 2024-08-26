class Country{
  String? countryCode;
  String? countryName;
  String? countryOfficialName;
  String? countryFlag;
  String? countryCurrencies;
  String? countryCurrenciesName;
  String? countryCurrenciesSymbol;

  String? region;
  String? languages;
  String? population;
  String? capitals;


Country.mapOlustur(Map<String,dynamic> ulkeMap){
 countryCode=ulkeMap["cca2"]??"";
 countryName=ulkeMap["name"]?["common"]??"";
 countryOfficialName=ulkeMap["name"]?["official"]??"";
 countryFlag=ulkeMap["flags"]?["png"]??"";
 var currencies = ulkeMap["currencies"] as Map<String, dynamic>? ?? {};
    if (currencies.isNotEmpty) {
      countryCurrencies = currencies.keys.first;
      var currencyDetails = currencies[countryCurrencies] as Map<String, dynamic>;
      countryCurrenciesName = currencyDetails["name"];
      countryCurrenciesSymbol = currencyDetails["symbol"];
    }
  region=ulkeMap["region"];
  var Languages = ulkeMap["languages"] as Map<String,dynamic>? ?? {};
  if(Languages.isNotEmpty){
    String languagesCode=Languages.keys.first;
    languages=ulkeMap["languages"][languagesCode];
  }
  else{
    languages="";
  }
  population=ulkeMap["population"].toString();
  capitals=(ulkeMap["capital"] as List<dynamic>).isNotEmpty ? ulkeMap["capital"][0] : "";
}


}
/*
[
  {
    "flags": {
      "png": "https://flagcdn.com/w320/gs.png",
      "svg": "https://flagcdn.com/gs.svg",
      "alt": ""
    },
    "name": {
      "common": "South Georgia",
      "official": "South Georgia and the South Sandwich Islands",
      "nativeName": {
        "eng": {
          "official": "South Georgia and the South Sandwich Islands",
          "common": "South Georgia"
        }
      }
    },
    "cca2": "GS",
    "currencies": {
      "SHP": {
        "name": "Saint Helena pound",
        "symbol": "£"
      }
    },
    "capital": [
      "King Edward Point"
    ],
    "region": "Antarctic",
    "languages": {
      "eng": "English"
    },
    "population": 30
  }

]


*/