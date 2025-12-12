import 'dart:convert';

import 'package:repairo_app_new/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllLocationsWebservice {
  Future<Map<String, dynamic>> getlocations(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth_token');
    final url = Uri.parse('${AppConstants.baseUrl}/user/saved-location');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('locations info: ${response.body}');
      final dataa = jsonDecode(response.body);
      return dataa; // رجّع الـ response كامل
    } else {
      print('Failed to get locations info: ${response.statusCode}');
      throw Exception('locations info failed');
    }
  }
}
