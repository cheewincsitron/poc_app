import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/application/di/domain/banner_repo.dart';
import 'package:poc_app/di.dart';
import 'package:poc_app/domain/failures/failure.dart';
import 'package:poc_app/entities/banner.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerRepo _bannerRepo = s<BannerRepo>();

  BannerCubit() : super(BannerInitial());

  void onGetBannerList() async {
    emit(BannerLoading());
    await Future.delayed(const Duration(seconds: 1));
    final Either<Failure, List<BannerEntity>> result =
        await _bannerRepo.fetchBannerList();
    result.fold(
      (l) => {emit(BannerFetchFailed())},
      (r) => {emit(BannerFetchSuccess(r))},
    );
  }
}
