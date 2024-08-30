import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Utils/constants.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 60,
        ),
        SizedBox(
            height: 250,
            width: 300,
            child: SvgPicture.asset(splash_svg)),
        const SizedBox(
          height: 30,
        ),
        Text(title, style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(
          height: 15,
        ),
        Text(subTitle, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  } // Column
}
