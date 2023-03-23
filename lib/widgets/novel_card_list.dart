import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_app/widgets/shimmer_loading.dart';
import 'package:sizer/sizer.dart';

import '../presentations/cubit/catagory/catagory_cubit.dart';
import 'novel_card.dart';

class NovelCardList extends StatelessWidget {
  const NovelCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      height: 202,
      child: BlocBuilder<CatagoryCubit, CatagoryState>(
        builder: (context, state) {
          if (state is CatagoryFetchSuccess) {
            final list = state.list;

            return ListView.separated(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: ((context, index) => const SizedBox(
                    width: 12,
                  )),
              itemBuilder: ((context, index) {
                final item = list[index];
                return NovelCard(img: item.imageUrl, title: item.name);
              }),
            );

            // return Row(
            //   children: [
            //     ...List.generate(
            //       list.length,
            //       (index) => NovelCard(
            //           img: list[index].imageUrl, title: list[index].name),
            //     )
            //   ],
            // );
          }

          return _buildCardLoading();
        },
      ),
    );
  }

  Widget _buildCardLoading() {
    return ListView.separated(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      separatorBuilder: ((context, index) => const SizedBox(
            width: 12,
          )),
      itemBuilder: ((context, index) {
        return SizedBox(
          width: 164,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerLoading.rectangular(
                height: 140,
              ),
              SizedBox(
                height: 8,
              ),
              ShimmerLoading.rectangular(
                height: 8,
                width: 40,
              ),
              SizedBox(
                height: 8,
              ),
              ShimmerLoading.rectangular(
                height: 12,
                width: 100,
              )
            ],
          ),
        );
      }),
    );
  }
}
