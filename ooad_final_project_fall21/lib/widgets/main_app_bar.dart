import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';
import 'package:ooad_final_project_fall21/theme/fontsizes.dart';
import 'package:ooad_final_project_fall21/theme/helper.dart';
import 'package:ooad_final_project_fall21/theme/padding.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0.8,
        brightness: Brightness.light,
        backgroundColor: textWhite,
        automaticallyImplyLeading: false,
        primary: false,
        excludeHeaderSemantics: true,
        flexibleSpace: SafeArea(
          child: Container(
            padding:
                EdgeInsets.only(left: leftMainPadding, right: rightMainPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Store Details",
                          style: TextStyle(
                              color: textBlack,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        getSvgIcon("arrow_right_icon.svg"),
                      ],
                    ),
                    Row(
                      children: [
                        getSvgIcon("search_icon.svg"),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width:
                      (size.width - (leftMainPadding + rightMainPadding + 60)),
                  child: Text(
                    "Boulder, Colorado",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: primary,
                      fontSize: subTitleFontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
