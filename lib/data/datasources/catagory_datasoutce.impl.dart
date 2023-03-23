// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poc_app/application/di/data/catagory_datasoruce.dart';
import 'package:poc_app/data/models/catagory_model.dart';
import 'package:poc_app/data/services/api_service.dart';

class CatagoryDatasourceImpl implements CatagoryDatasource {
  final ApiService apiService;
  CatagoryDatasourceImpl({
    required this.apiService,
  });

  static String mainUrl = "${dotenv.env['BASE_API']}/categories";

  @override
  Future<List<CatagoryModel>> getList() async {
    try {
      // var response = await apiService.fetchData(url: mainUrl);
      // List data = response['data'];
      // var list = data.map((item) => CatagoryModel.fromMap(item)).toList();
      List<CatagoryModel> list = [
        CatagoryModel(id: "1", name: "1", description: "1", imageUrl: "1"),
        CatagoryModel(id: "1", name: "1", description: "1", imageUrl: "1"),
        CatagoryModel(id: "1", name: "1", description: "1", imageUrl: "1"),
        CatagoryModel(id: "1", name: "1", description: "1", imageUrl: "1"),
        CatagoryModel(id: "1", name: "1", description: "1", imageUrl: "1"),
        CatagoryModel(id: "1", name: "1", description: "1", imageUrl: "1"),
        CatagoryModel(id: "1", name: "1", description: "1", imageUrl: "1"),
      ];
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("NewsDatasourceFromApi - fetchNewsList");
    }
  }
}
