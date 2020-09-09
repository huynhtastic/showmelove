import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BorderedImage extends StatelessWidget {
  final String imageUrl;
  const BorderedImage(this.imageUrl, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return Container();

    return CachedNetworkImage(
      key: Key('image'),
      imageBuilder: buildImage,
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

Widget buildImage(BuildContext context, ImageProvider imageProvider) =>
    Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image(image: imageProvider),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.blue,
          style: BorderStyle.solid,
          width: 8,
        ),
      ),
    );
