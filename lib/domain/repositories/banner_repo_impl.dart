// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:poc_app/application/di/data/banner_datasource.dart';
import 'package:poc_app/application/di/domain/banner_repo.dart';
import 'package:poc_app/domain/failures/failure.dart';
import 'package:poc_app/domain/failures/fetch_failure.dart';
import 'package:poc_app/entities/banner.dart';

class BannerRepoImpl implements BannerRepo {
  final BannerDataSource bannerDataSource;

  BannerRepoImpl({
    required this.bannerDataSource,
  });

  @override
  Future<Either<Failure, List<BannerEntity>>> fetchBannerList() async {
    try {
      var list = await bannerDataSource.getBannerList();
      var entities =
          list.map((item) => BannerEntity.fromMap(item.toMap())).toList();
      // var entities = list
      //     .map((item) =>
      //         BannerEntity(id: item.id, name: item.name, image: item.imageUrl))
      //     .toList();

      return Right(entities);
    } catch (e) {
      return Left(FetchFailure(message: "BannerRepo - getBannerList failed"));
    }
  }
}
