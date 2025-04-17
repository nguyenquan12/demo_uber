import 'dart:convert';

import 'package:http/http.dart';
import 'package:uber_app/models/googleMapSearchModel%20.dart';
import 'package:uber_app/models/userModel.dart';
import 'package:uber_app/network/netWorkUtils.dart';

Future<UserModel> logInApi(Map request) async {
  Response response = await buildHttpResponse('login',
      request: request, method: HttpMethod.POST);
  var json = jsonDecode(response.body);
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(json);
    return user;
  } else {
    throw json['message'];
  }
}

Future<GoogleMapSearchModel> searchAddressRequest({String? search}) async {
  final encodedSearch = Uri.encodeQueryComponent(search ?? '');
  final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$encodedSearch'
      '&key=$googleMapAPIKey'
      '&components=country:$defaultCountry';
  print("API Request URL: $url"); // In URL để kiểm tra
  return GoogleMapSearchModel.fromJson(await handleResponse(
      await buildHttpResponse(url, method: HttpMethod.GET)));
}
