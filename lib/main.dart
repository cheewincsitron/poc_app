import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poc_app/presentations/bloc/app_bloc_observer.dart';
import 'package:poc_app/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'package:poc_app/presentations/bloc/couter_a_bloc/counter_a_bloc.dart';
import 'package:poc_app/presentations/cubit/banner/banner_cubit.dart';
import 'package:poc_app/presentations/cubit/card/card_cubit.dart';
import 'package:poc_app/presentations/cubit/catagory/catagory_cubit.dart';
import 'package:poc_app/presentations/cubit/login/login_cubit.dart';
import 'package:poc_app/presentations/cubit/todo/todo_cubit.dart';
import 'package:poc_app/theme.dart';
import 'package:sizer/sizer.dart';

import 'di.dart';
import 'router/app_go_router.dart';

void main() async {
  // runApp(const App());
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: "dotenv");
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());

  Bloc.observer = AppBlocObserver();
  initDependencyInjection();

  // check if is running on Web
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "1373493493466183",
      cookie: true,
      xfbml: true,
      version: "v14.0",
    );
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final AppRouter _appRouter = AppRouter();

    final counterABloc = BlocProvider(create: (context) => CounterABloc());

    // final loginBloc = BlocProvider(
    //     create: (context) => LoginBloc(
    //         userRepository: userRepository,
    //         authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)));

    final authBloc = BlocProvider(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
      lazy: false,
    );
    final loginCubit = BlocProvider(
        create: (context) =>
            LoginCubit(BlocProvider.of<AuthenticationBloc>(context)));
    final todoCubit = BlocProvider(create: (context) => TodoCubit());
    final cardCubit = BlocProvider(create: (context) => CardCubit());
    final bannerCubit = BlocProvider(create: (context) => BannerCubit());
    final catagoryCubit =
        BlocProvider(create: (context) => CatagoryCubit()..onGetCatagoryList());

    return MultiBlocProvider(
      providers: [
        counterABloc,
        authBloc,
        // loginBloc,
        loginCubit,
        todoCubit,
        cardCubit,
        bannerCubit,
        catagoryCubit,
      ],
      child: Builder(builder: (context) {
        return Sizer(builder: (context, orientation, deviceType) {
          return BuildApp();
        });
      }),
    );
  }
}

class BuildApp extends StatefulWidget {
  const BuildApp({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildApp> createState() => _BuildAppState();
}

class _BuildAppState extends State<BuildApp> {
  late final GoRouter appGoRouter =
      routes(BlocProvider.of<AuthenticationBloc>(context));

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    // print('ready in 3...');
    // await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // onGenerateRoute: _appRouter.onGenerateRoute,
      // home: SplashScreen(),
      routerConfig: appGoRouter,
      // routerDelegate: appGoRouter.routerDelegate,
      // routeInformationParser: appGoRouter.routeInformationParser,
      // routeInformationProvider: appGoRouter.routeInformationProvider,
    );
  }
}
