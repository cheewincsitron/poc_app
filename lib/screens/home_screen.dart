// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/presentations/bloc/couter_a_bloc/counter_a_bloc.dart';
import 'package:poc_app/presentations/cubit/banner/banner_cubit.dart';
import 'package:poc_app/widgets/banner_carousel.dart';
import 'package:poc_app/widgets/novel_card_list.dart';
import 'package:poc_app/widgets/responsive.dart';
import 'package:poc_app/widgets/section_header.dart';
import 'package:sizer/sizer.dart';

import '../presentations/cubit/catagory/catagory_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BannerCubit>().onGetBannerList();
    context.read<CatagoryCubit>().onGetCatagoryList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: !Responsive.isDesktop(context) ? const CustomAppBar() : null,
        body: RefreshIndicator(
          onRefresh: () async {
            // Future block = context.read<BannerCubit>().stream.first;
            context.read<BannerCubit>().onGetBannerList();
            context.read<CatagoryCubit>().onGetCatagoryList();
            // await block;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                  //Banner Carousel
                  const BannerCarousel(),
                  //SearchBar
                  Responsive(
                    desktop: SizedBox.shrink(),
                    mobile: Container(
                      width: double.infinity,
                      transform: Matrix4.translationValues(0.0, 25.0, 0.0),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildSearchBar(),
                    ),
                  )
                ]),
                Container(
                  constraints: Responsive.isDesktop(context)
                      ? const BoxConstraints(maxWidth: 1080)
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 36,
                      ),
                      SectionHeader(
                        text: "แนวเด็ดที่คุณชอบ",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const NovelCardList(),
                      // ),
                      Container(
                        color: Colors.white,
                        height: 50.h,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 50.h,
                      ),
                      Container(
                        color: Colors.white,
                        height: 50.h,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 50.h,
                      ),
                      Container(
                        color: Colors.white,
                        height: 50.h,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 50.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.grey,
          )),
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          // fillColor: Colors.amber,
          // filled: true,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "ค้นหานิยาย เช่น นิยายรัก, นิยายแฟนตาซี,...",
          hintStyle: TextStyle(color: Colors.grey[300]),
          prefixIcon: Icon(
            Icons.search,
            size: 24,
            color: Colors.grey[300],
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 16,
          ),
        ),
      ),
    );
    // return TextFormField(
    //   decoration: InputDecoration(
    //     fillColor: Colors.white,
    //     filled: true,
    //     contentPadding: EdgeInsets.all(16),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(24),
    //     ),
    //     hintText: "ค้นหานิยาย เช่น นิยายรัก, นิยายแฟนตาซี,...",
    //     prefixIcon: const Padding(
    //       padding: EdgeInsets.only(left: 16.0),
    //       child: Icon(
    //         Icons.search,
    //         // color: Colors.green,
    //       ),
    //     ),
    //   ),
    //   autovalidateMode: AutovalidateMode.onUserInteraction,
    //   validator: (value) {
    //     if (value!.startsWith("a")) {
    //       return "length";
    //     }

    //     return null;
    //   },
    // );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Logo",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      actions: [
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.green,
            shape: CircleBorder(),
          ),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            splashRadius: 3.h,
            icon: const Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {},
            iconSize: 3.h,
          ),
        ),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     shape: const CircleBorder(),
        //     padding: const EdgeInsets.all(0),
        //   ),
        //   child: const Icon(
        //     Icons.notifications,
        //     size: 24,
        //   ),
        //   onPressed: () {},
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 1.5.h),
        //   child: RawMaterialButton(
        //     onPressed: () {},
        //     elevation: 2.0,
        //     fillColor: Colors.green[700],
        //     padding: const EdgeInsets.all(0),
        //     shape: const CircleBorder(),
        //     child: Icon(
        //       Icons.notifications_none_outlined,
        //       size: 3.h,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        SizedBox(
          width: 2.w,
        )
      ],
    );
  }
}
