import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../colors/app_colors.dart';
import '../routes/routes.dart';
import '../svgs/svg_images.dart';

class CustomGridTile extends StatelessWidget {
  final String svgImage, title;
  final Widget route;
  const CustomGridTile({Key? key, required this.svgImage, required this.title, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
            alignment: Alignment.center,
            backgroundColor: MaterialStatePropertyAll(AppColors.baseGrey20Color),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),
              ),
            ),
          ),
          onPressed: () {
            if (title == "Logout"){
              Navigator.pushReplacementNamed(context, "/");
              // Navigator.pop(context);
            } else {
              RoutingPage.goToNextPage(
                context: context,
                navigateTo: route,
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WebsafeSvg.asset(
                svgImage,
                width: 25,
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    height: 1.2,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700]),
              ),
            ],
          ),
        ));
  }
}

/*Container(
        margin: const EdgeInsets.all(10.0),
        // padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            boxShadow: [
          BoxShadow(
              color: AppColors.baseGrey30Color,
              offset: Offset.zero,
              blurRadius: 3.0,
              spreadRadius: 2.0
          )
        ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColors.baseGrey20Color
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WebsafeSvg.asset(
            svgImage,
            width: 25,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w700,
              color: Colors.grey[700]
            ),
          ),
        ],
      )
    )*/
