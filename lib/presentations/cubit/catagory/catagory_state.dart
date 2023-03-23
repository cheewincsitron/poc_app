part of 'catagory_cubit.dart';

abstract class CatagoryState extends Equatable {
  const CatagoryState();

  @override
  List<Object> get props => [];
}

class CatagoryInitial extends CatagoryState {}

class CatagoryLoading extends CatagoryState {}

class CatagoryFetchSuccess extends CatagoryState {
  final List<CatagoryEntity> _list;

  const CatagoryFetchSuccess(this._list);

  List<CatagoryEntity> get list => _list;

  CatagoryFetchSuccess copyWith({
    List<CatagoryEntity>? list,
  }) {
    return CatagoryFetchSuccess(
      list ?? _list,
    );
  }

  @override
  List<Object> get props => [_list];
}

class CatagoryFetchFailed extends CatagoryState {}
