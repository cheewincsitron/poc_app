import 'package:get_it/get_it.dart';
import 'package:poc_app/application/di/data/auth_datasource.dart';
import 'package:poc_app/application/di/data/banner_datasource.dart';
import 'package:poc_app/application/di/data/catagory_datasoruce.dart';
import 'package:poc_app/application/di/domain/auth_repo.dart';
import 'package:poc_app/application/di/domain/banner_repo.dart';
import 'package:poc_app/application/di/domain/catagory_repo.dart';
import 'package:poc_app/data/datasources/auth_datasource_impl.dart';
import 'package:poc_app/data/datasources/banner_datasource_impl.dart';
import 'package:poc_app/data/datasources/catagory_datasoutce.impl.dart';
import 'package:poc_app/domain/repositories/auth_repo_impl.dart';
import 'package:poc_app/domain/repositories/banner_repo_impl.dart';
import 'package:poc_app/domain/repositories/catagory_repo_impl.dart';
import 'data/requester/dio_requester.dart';
import 'data/services/http_service.dart';

final GetIt s = GetIt.instance;

void initDependencyInjection() {
  /// datasources
  s.registerSingleton<AuthDatasource>(
      AuthDatasourceImpl(apiService: HttpService(requester: DioRequester())));
  s.registerSingleton<BannerDataSource>(
      BannerDatasourceImpl(apiService: HttpService(requester: DioRequester())));
  s.registerSingleton<CatagoryDatasource>(CatagoryDatasourceImpl(
      apiService: HttpService(requester: DioRequester())));

  /// repositories
  s.registerSingleton<AuthRepo>(
      AuthRepoImpl(authDatasource: s<AuthDatasource>()));
  s.registerSingleton<BannerRepo>(
      BannerRepoImpl(bannerDataSource: s<BannerDataSource>()));
  s.registerSingleton<CatagoryRepo>(
      CatagoryRepoImpl(catagoryDataSource: s<CatagoryDatasource>()));

  /// usecases
  // s.registerSingleton<NewsUsecase>(NewsUsecaseImpl(newsRepo: s<NewsRepo>()));
}
