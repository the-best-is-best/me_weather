import 'package:flutter/material.dart';
import 'package:mit_x/mit_x.dart';

import '../../../gen/assets.gen.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      const $AssetsImagesGen().background.path,
      width: MitX.width,
      height: MitX.height,
      fit: BoxFit.cover,
    );
  }
}
