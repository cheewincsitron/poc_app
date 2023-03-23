import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      print(bloc);
    }
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      print(change);
    }
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print("error:$error stackTrace:$stackTrace");
    }
    super.onError(bloc, error, stackTrace);
  }

  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   if (kDebugMode) {
  //     print(event);
  //   }
  //   super.onEvent(bloc, event);
  // }
}
