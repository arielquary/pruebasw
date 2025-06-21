import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plurione_app/components/plurione_progress_indicator.dart';

class PNetworkImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width,height;
  
  const PNetworkImage(this.image, {super.key, this.fit = BoxFit.contain, this.height = 60,this.width = 60});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) => Center(child: PluriOneProgressIndicator()),
      errorWidget: (context, url, error) => Image.asset('lib/assets/images/placeholder.jpg',fit: BoxFit.cover,),
      fit: fit,
      width: width,
      height: height,
    );
  }
}