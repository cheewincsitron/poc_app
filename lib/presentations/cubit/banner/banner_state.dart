// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banner_cubit.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerFetchSuccess extends BannerState {
  final List<BannerEntity> _list;

  const BannerFetchSuccess(this._list);

  List<BannerEntity> get list => _list;

  BannerFetchSuccess copyWith({
    List<BannerEntity>? list,
  }) {
    return BannerFetchSuccess(
      list ?? _list,
    );
  }

  @override
  List<Object> get props => [_list];
}

class BannerFetchFailed extends BannerState {}
