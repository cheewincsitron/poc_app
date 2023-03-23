import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/presentations/cubit/banner/banner_cubit.dart';
import 'package:poc_app/widgets/responsive.dart';
import 'package:poc_app/widgets/shimmer_loading.dart';
import 'package:sizer/sizer.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerLoading) {
            return const ShimmerLoading.rectangular(height: 300);
          } else if (state is BannerFetchSuccess) {
            return Responsive(
              desktop: CarouselSlider.builder(
                options: CarouselOptions(
                  // height: 300,
                  // height: Responsive.screenSize(context).height * 0.35,
                  aspectRatio: 3.75,
                  viewportFraction: 0.33,
                  // initialPage: 0,
                  // enableInfiniteScroll: true,
                  // reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: Responsive.isTablet(context),
                  enlargeFactor: 0,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.hardEdge,
                ),
                itemCount: state.list.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = state.list[index].image;
                  return _buildItem(urlImage, index);
                },
              ),
              tablet: CarouselSlider.builder(
                options: CarouselOptions(
                  // height: 300,
                  // height: Responsive.screenSize(context).height * 0.35,
                  aspectRatio: 1.875,
                  viewportFraction: 0.6,
                  // initialPage: 0,
                  // enableInfiniteScroll: true,
                  // reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: Responsive.isTablet(context),
                  enlargeFactor: 0,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.hardEdge,
                ),
                itemCount: state.list.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = state.list[index].image;
                  return _buildItem(urlImage, index);
                },
              ),
              mobile: CarouselSlider.builder(
                options: CarouselOptions(
                  // height: 300,
                  // height: Responsive.screenSize(context).height * 0.35,
                  aspectRatio: 1.25,
                  viewportFraction: 1,
                  // initialPage: 0,
                  // enableInfiniteScroll: true,
                  // reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: Responsive.isTablet(context),
                  enlargeFactor: 0,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.hardEdge,
                ),
                itemCount: state.list.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = state.list[index].image;
                  return _buildItem(urlImage, index);
                },
              ),
            );
          }
          return const Center(
            child: Text("Failed.."),
          );
        },
      ),
    );
  }

  Widget _buildItem(String urlImage, int index) {
    return Container(
      margin: Responsive.isTablet(context) ? const EdgeInsets.all(8) : null,
      // color: Colors.green,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: Responsive.isTablet(context)
            ? BorderRadius.circular(16)
            : BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
