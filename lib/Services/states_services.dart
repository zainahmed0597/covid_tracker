import 'dart:convert';
import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fecthWorldStatesRecords () async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200){
      var data  =  jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}
