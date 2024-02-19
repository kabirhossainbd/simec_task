


import 'package:get/get.dart';
import 'package:test_task/remote_service/api_client.dart';

class HomeRepo {
  final ApiClient apiSource;
  HomeRepo({required this.apiSource});

  Future<Response> getRepo() async {
    return await apiSource.getData('search/repositories?q=Q');
  }
  Future<Response> getSearchRepo(String query) async {
    return await apiSource.getData('search/repositories?q=$query');
  }

}