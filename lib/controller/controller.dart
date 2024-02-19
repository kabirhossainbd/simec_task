import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/model/repo.dart';
import 'package:test_task/model/response.dart';


class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});


 //  List<Items> _itemsList = [];
 //
 //  List<Items> get itemsList => _itemsList;
 //
 // Future<ResponseModel> getApiCall() async {
 //    Response response = await homeRepo.getRepo();
 //    ResponseModel responseModel;
 //    if (response.statusCode == 200) {
 //      _itemsList = [];
 //      _itemsList.addAll(SearchModel
 //          .fromJson(response.body)
 //          .items ?? []);
 //      responseModel = ResponseModel(true, response.statusCode.toString());
 //      _isItemEmpty = false;
 //    } else {
 //      responseModel = ResponseModel(false, response.statusCode.toString());
 //      _isItemEmpty = false;
 //    }
 //    update();
 //    return responseModel;
 //  }

  bool _isItemEmpty = false;
  bool get isItemEmpty => _isItemEmpty;


  List<Items> _searchItemsList = [];
  List<Items> get searchItemsList => _searchItemsList;

  Future<ResponseModel> getSearchApiCall(String query) async {
    _isItemEmpty = true;
    update();
    Response response = await homeRepo.getSearchRepo(query);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      _searchItemsList = [];
      _searchItemsList.addAll(SearchModel.fromJson(response.body).items ?? []);
      responseModel = ResponseModel(true, response.statusCode.toString());
      _isItemEmpty = false;
    } else {
      responseModel = ResponseModel(false, response.statusCode.toString());

    }
    _isItemEmpty = false;
    update();
    return responseModel;
  }

}



class ResponseModel{
  bool? isSuccess;
  String? message;

  ResponseModel(this.isSuccess, this.message);

}