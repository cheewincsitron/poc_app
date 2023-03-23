import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/di.dart';

import '../../../application/di/domain/catagory_repo.dart';
import '../../../domain/failures/failure.dart';
import '../../../entities/catagory.dart';

part 'catagory_state.dart';

class CatagoryCubit extends Cubit<CatagoryState> {
  CatagoryCubit() : super(CatagoryInitial());

  final CatagoryRepo _catagoryRepo = s<CatagoryRepo>();

  void onGetCatagoryList() async {
    emit(CatagoryLoading());
    await Future.delayed(const Duration(seconds: 3));
    final Either<Failure, List<CatagoryEntity>> result =
        await _catagoryRepo.fetchCatagoryList();
    result.fold(
      (l) => {emit(CatagoryFetchFailed())},
      (r) => {emit(CatagoryFetchSuccess(r))},
    );
  }
}
