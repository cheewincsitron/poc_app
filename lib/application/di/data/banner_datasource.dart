import 'package:poc_app/data/models/banner_model.dart';

abstract class BannerDataSource {
  Future<List<BannerModel>> getBannerList();
}
