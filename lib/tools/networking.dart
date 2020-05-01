import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  // get data from weather
  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

//var temp = decodeData['main']['temp'];
//var condition = decodeData['weather'][0]['id'];
//var cityName = decodeData['name'];
//print(temp);
//print(condition);
//print(cityName);
