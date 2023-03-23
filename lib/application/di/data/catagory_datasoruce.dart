import '../../../data/models/catagory_model.dart';

abstract class CatagoryDatasource {
  Future<List<CatagoryModel>> getList();
}
