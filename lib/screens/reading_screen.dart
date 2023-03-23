import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/presentations/cubit/catagory/catagory_cubit.dart';
import 'package:poc_app/widgets/responsive.dart';
import 'package:poc_app/widgets/slider_appbar.dart';
import 'package:poc_app/widgets/slider_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:html';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  GlobalKey key = GlobalKey();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ScrollController _scorllController = ScrollController();
  final ScrollController _contentScrollController = ScrollController();

  bool _isShowNav = true;
  double _currentSliderValue = 0;
  bool _canHideNav = false;
  double _contentBottomOffset = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // _scorllController.addListener(listen);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   // _scorllController.addListener(() {
    //   //   print('scrolling');
    //   // });
    //   _scorllController.position.isScrollingNotifier.addListener(() {
    //     if (!_scorllController.position.isScrollingNotifier.value) {
    //       print('scroll is stopped');
    //       // if (_scorllController.offset ==
    //       //     _scorllController.position.maxScrollExtent) {
    //       //   showNav();
    //       // }
    //     } else {
    //       print('scroll is started');
    //       // hideNav();
    //     }
    //   });
    // });
    context.read<CatagoryCubit>().onGetCatagoryList();
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    _scorllController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: SliderAppAppBar(
          visible: _isShowNav,
          child: AppBar(
            title: const Text("Reading"),
            backgroundColor: Colors.white,
          ),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: GestureDetector(
          onTap: () {
            toggleNav();
          },
          child: CustomRefreshIndicator(
            leadingScrollIndicatorVisible: false,
            trailingScrollIndicatorVisible: true,
            triggerMode: IndicatorTriggerMode.anywhere,
            trigger: IndicatorTrigger.trailingEdge,
            builder: MaterialIndicatorDelegate(
              backgroundColor: Colors.white,
              // displacement: 80,
              edgeOffset: 40,
              withRotation: false,
              builder: (context, controller) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: const AlwaysStoppedAnimation(Colors.green),
                        value: controller.isDragging || controller.isArmed
                            ? controller.value.clamp(0.0, 1.0)
                            : null,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_downward_sharp,
                      color: Colors.green,
                      size: 28,
                    ),
                  ],
                );
                // const Icon(
                //   Icons.accessibility,
                //   color: Colors.black,
                //   size: 30,
                // );
              },
            ),
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (!_canHideNav) return false;
                //start scroll
                if (scrollNotification is ScrollStartNotification) {
                  if (scrollNotification.metrics.pixels + 20 <=
                      scrollNotification.metrics.maxScrollExtent) {
                    hideNav();
                  }
                } else if (scrollNotification is ScrollUpdateNotification) {
                  //on scroll
                  final double valueToSet = (scrollNotification.metrics.pixels /
                          _contentBottomOffset *
                          100)
                      .ceil()
                      .toDouble();
                  if (valueToSet <= 100) {
                    setState(() {
                      _currentSliderValue = valueToSet;
                    });
                  }
                } else if (scrollNotification is ScrollEndNotification) {
                  //end scroll
                  if (scrollNotification.metrics.pixels ==
                      scrollNotification.metrics.maxScrollExtent) {
                    showNav();
                  } else {
                    hideNav();
                  }
                  if (scrollNotification.metrics.pixels <=
                      _contentBottomOffset) {
                    _setSharePrefsPostion(scrollNotification.metrics.pixels);
                  }
                }
                return false;
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: _scorllController,
                child: Column(
                  children: [
                    BlocConsumer<CatagoryCubit, CatagoryState>(
                      listener: (context, state) async {
                        if (state is CatagoryFetchSuccess) {
                          _autoScrollTo();
                        }
                      },
                      builder: (context, state) {
                        if (state is CatagoryFetchSuccess) {
                          return ListView.builder(
                            controller: _contentScrollController,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.list.length + 8,
                            itemBuilder: (context, index) => Container(
                              color:
                                  index % 2 == 0 ? Colors.grey : Colors.green,
                              height: 500,
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),

                    //2000
                    Container(
                      key: key,
                      width: double.infinity,
                      height: 1000,
                      color: Colors.yellow[100],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0, 24, 0, 84),
                      color: Colors.orange[100],
                      child: const Text("ดึงเพื่อไปตอนต่อไป"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SliderBottomBar(
          height: 70,
          isVisible: _isShowNav,
          child: Container(
            color: Colors.transparent,
            height: 70,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    color: Colors.white,
                    height: 60,
                  ),
                  Positioned(
                    top: -10,
                    left: -10,
                    right: -10,
                    child: _buildSlider(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setSharePrefsPostion(double position) {
    _prefs.then((SharedPreferences prefs) {
      prefs.setDouble("scrollPosition", position);
    });
  }

  SliderTheme _buildSlider() {
    return SliderTheme(
      data: SliderThemeData(
        // here
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        divisions: 100,
        activeColor: Colors.red,
        inactiveColor: Colors.blue,
        label: _currentSliderValue.round().toString(),
        onChangeStart: (value) {
          setState(() {
            _canHideNav = false;
          });
        },
        onChangeEnd: (value) {
          setState(() {
            _canHideNav = true;
          });
        },
        onChanged: (double value) {
          // print("onChanged");
          setState(() {
            _currentSliderValue = value;
          });
          double offset = _contentBottomOffset * value / 100;
          _scorllController.jumpTo(offset
              // duration: Duration(milliseconds: 10),
              // curve: Curves.ease
              );
          _setSharePrefsPostion(offset);
        },
      ),
    );
  }

  void toggleNav() {
    _isShowNav ? hideNav() : showNav();
  }

  void showNav() {
    if (!_isShowNav) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      setState(() {
        _isShowNav = true;
      });
    }
  }

  void hideNav() {
    if (_isShowNav) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
      setState(() {
        _isShowNav = false;
      });
    }
  }

  void listen() {
    // print(_scorllController.offset);
    // print(_scorllController.position.maxScrollExtent);
    if (_scorllController.offset ==
        _scorllController.position.maxScrollExtent) {
      showNav();
    } else {
      hideNav();
    }
  }

  void _autoScrollTo() async {
    final double screenHeight = Responsive.screenSize(context).height;

    await Future.delayed(const Duration(milliseconds: 10));
    if (!mounted) return;
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double y = position.dy;

    setState(() {
      _contentBottomOffset = y - screenHeight < 0 ? y : y - screenHeight;
    });

    _prefs.then((SharedPreferences prefs) {
      double scrollPosition = prefs.getDouble('scrollPosition') ?? 0;

      _scorllController.jumpTo(scrollPosition);

      setState(() {
        _canHideNav = true;
        _currentSliderValue =
            (scrollPosition / _contentBottomOffset * 100).round().toDouble();
      });
    });
  }
}
