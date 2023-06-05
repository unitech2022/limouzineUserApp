import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final double height, width;
  final String image;
  final IconData icon;
  const CircleImageWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.image,this.icon=Icons.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: CachedNetworkImage(
          imageUrl: image, height: height, width: width, fit: BoxFit.cover,
          // imageBuilder: (context, imageProvider) => Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: imageProvider,
          //         fit: BoxFit.cover,
          //         colorFilter:
          //         ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
          //   ),
          // ),
          placeholder: (context, url) => SizedBox(),
          errorWidget: (context, url, error) => Icon(
            icon,
            size: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}