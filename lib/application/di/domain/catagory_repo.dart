import 'package:dartz/dartz.dart';

import '../../../domain/failures/failure.dart';
import '../../../entities/catagory.dart';

abstract class CatagoryRepo {
  Future<Either<Failure, List<CatagoryEntity>>> fetchCatagoryList();
}
