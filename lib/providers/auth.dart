


import 'dart:convert';

import 'package:bus_tracker/models/logInmodel.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:http/http.dart' as http;

final loginProvider=FutureProvider.family<LogInModel,LoginParams>((ref, params)async{
try{
    var url="https://raka1503.pythonanywhere.com/login/";
    final response=await  http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userID':params.userID,
        'password':params.password,
      }),
    );
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      return LogInModel.fromJson(data);
    }
    else{
        return LogInModel(message: 'Error: ${response.statusCode}', status: false, userID:null );
    }

}
catch(e){
    return LogInModel(message: e.toString(), status: false, userID:null );
}
});
final registerProvider=FutureProvider.family<bool,LoginParams>((ref, params)async{
try{
    var url="https://raka1503.pythonanywhere.com/register/";
    final response=await  http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userID':params.userID,
        'password':params.password,
      }),
    );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==201){
      final data=jsonDecode(response.body);
      return true;
    }
    else{
        return false;
    }

}
catch(e){
    return false;
}
});


final userID=StateProvider<String>((ref) => "");
