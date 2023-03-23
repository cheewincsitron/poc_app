// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:poc_app/domain/failures/failure.dart';
import 'package:poc_app/domain/failures/fetch_failure.dart';

import '../../application/di/data/catagory_datasoruce.dart';
import '../../application/di/domain/catagory_repo.dart';
import '../../entities/catagory.dart';

class CatagoryRepoImpl implements CatagoryRepo {
  final CatagoryDatasource catagoryDataSource;

  CatagoryRepoImpl({
    required this.catagoryDataSource,
  });

  @override
  Future<Either<Failure, List<CatagoryEntity>>> fetchCatagoryList() async {
    try {
      var list = await catagoryDataSource.getList();
      var entities =
          list.map((item) => CatagoryEntity.fromMap(item.toMap())).toList();
      // var entities = list
      //     .map((item) =>
      //         CatagoryEntity(id: item.id, name: item.name, image: item.imageUrl))
      //     .toList();

      return Right(entities);
    } catch (e) {
      return Left(
          FetchFailure(message: "CatagoryRepo - getCatagoryList failed"));
    }
  }
}
