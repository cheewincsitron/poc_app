// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NovelCard extends StatelessWidget {
  const NovelCard({
    Key? key,
    required this.img,
    required this.title,
  }) : super(key: key);

  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ClipRRect(
        //   borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        //   child: Container(
        //     width: 164,
        //     child: Image.network(
        //       img,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: CachedNetworkImage(
            imageUrl: img,
            width: 164,
            height: 140,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "นักเขียน นักเขียน",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Row(
              children: const [
                Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 12,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "1.5 k",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(Icons.remove_red_eye_outlined,
                    color: Colors.grey, size: 12),
                SizedBox(
                  width: 4,
                ),
                Text("1.5 k",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            )
          ],
        )
      ],
    );
  }
}
