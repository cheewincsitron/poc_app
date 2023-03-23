// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poc_app/application/di/data/banner_datasource.dart';
import 'package:poc_app/data/models/banner_model.dart';
import 'package:poc_app/data/services/api_service.dart';

class BannerDatasourceImpl implements BannerDataSource {
  final ApiService apiService;
  BannerDatasourceImpl({
    required this.apiService,
  });

  static String mainUrl = "${dotenv.env['BASE_API']}/banners";

  @override
  Future<List<BannerModel>> getBannerList() async {
    try {
      var response = await apiService.fetchData(url: mainUrl);
      List data = response['data'];
      var list = data.map((item) => BannerModel.fromMap(item)).toList();
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("NewsDatasourceFromApi - fetchNewsList");
    }
  }
}
