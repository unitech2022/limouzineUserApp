import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final double height, width;
  final String image;
  const CircleImageWidget({super.key, required this.height ,required this.width ,required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(width / 2),
      child: CachedNetworkImage(
        imageUrl: image,height: height,width: width,fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: imageProvider,
          //       fit: BoxFit.cover,
          //       colorFilter:
          //       ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
          // ),
        ),
        placeholder: (context, url) => SizedBox(),
        errorWidget: (context, url, error) => Icon(Icons.person,size: 30,),
      ),
    );
  }
}
