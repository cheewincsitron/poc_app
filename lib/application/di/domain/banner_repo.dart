import 'package:dartz/dartz.dart';
import 'package:poc_app/domain/failures/failure.dart';
import 'package:poc_app/entities/banner.dart';

abstract class BannerRepo {
  Future<Either<Failure, List<BannerEntity>>> fetchBannerList();
}
