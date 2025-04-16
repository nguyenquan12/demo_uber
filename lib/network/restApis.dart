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
  return GoogleMapSearchModel.fromJson(await handleResponse(await buildHttpResponse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$googleMapAPIKey&components=country:${defaultCountry}',
      method: HttpMethod.GET)));
}
