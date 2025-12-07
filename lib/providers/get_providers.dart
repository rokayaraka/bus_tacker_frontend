import 'dart:convert';

import 'package:bus_tracker/models/bus.dart';
import 'package:bus_tracker/models/other.dart';
import 'package:bus_tracker/models/reportModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final submitReportProvider = FutureProvider.family<bool, ReportModel>((
  ref,
  params,
) async {
  try {
    var url = "https://raka1503.pythonanywhere.com/submit-report/";
    print(params.toString());
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userID": params.userID,
        "firstName": params.firstName,
        "lastName": params.lastName,
        "email": params.email,
        "department": params.department,
        "issueDescription": params.issueDescription,
        // "attachment": params.attachment,
      }),
    );
    print(  response.body);
    print(  response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
});

final fetchDeparturesProvider = FutureProvider<List<DepartureTimeModel>>((ref) async {
  try {
    var url = "https://raka1503.pythonanywhere.com/departure-times";
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = departureTimeListFromJson(jsonDecode(response.body));
      return data;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
});

final fetchRoutesProvider = FutureProvider<List<RouteModel>>((ref) async {
  try {
    var url = "https://raka1503.pythonanywhere.com/routes";
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = routeListFromJson(jsonDecode(response.body));
      return data;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
});

final fetchBusesProvider = FutureProvider.family<List<BusModel>,List<String>>((ref, params) async {
  try {
    var url;
    if(params.isEmpty){
      url = "https://raka1503.pythonanywhere.com/buses";
    }
    else{
          url = "https://raka1503.pythonanywhere.com/buses-by-departure/?routeID=${params[0]}&departureTime=${params[1]}";
    }
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = busListFromJson(jsonDecode(response.body));
      return data;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
});