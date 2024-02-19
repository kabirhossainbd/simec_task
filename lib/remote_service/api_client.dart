import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:test_task/remote_service/error_class.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  static const String noInternetMessage = 'Connection lost due to internet connection';
  final int timeoutInSeconds = 30;
  static const String noResponse = 'Request Timeout';
  ApiClient({required this.appBaseUrl,});


  Future<Response> getData(String uri) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: ');
      }
      http.Response remoteResponse = await http.get(
        Uri.parse(appBaseUrl+uri),
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(remoteResponse, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  Response handleResponse(http.Response response, String uri) {
    dynamic dataBody;
    try {
      dataBody = jsonDecode(response.body);
    }catch(e) {
      rethrow;
    }
    Response remoteResponse = Response(
      body: dataBody ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(remoteResponse.statusCode != 200 && remoteResponse.body != null && remoteResponse.body is !String) {
      if(remoteResponse.body.toString().startsWith('{errors: [{code:')) {
        ErrorClass errorResponse = ErrorClass.fromJson(remoteResponse.body);
        remoteResponse = Response(statusCode: remoteResponse.statusCode, body: remoteResponse.body, statusText: errorResponse.errors![0].message);
      }else if(remoteResponse.body.toString().startsWith('{message')) {
        remoteResponse = Response(statusCode: remoteResponse.statusCode, body: remoteResponse.body, statusText: remoteResponse.body['message']);
      }
    }else if(remoteResponse.statusCode != 200 && remoteResponse.body == null) {
      remoteResponse = const Response(statusCode: 1005, statusText: noInternetMessage);
    }
    if(foundation.kDebugMode) {
      debugPrint('====> API Response: [${remoteResponse.statusCode}] $uri\n${remoteResponse.body}');
    }
    return remoteResponse;
  }
}