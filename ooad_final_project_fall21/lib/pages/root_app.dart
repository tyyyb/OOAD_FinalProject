import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/pages/Customer/cart.dart';
import 'package:ooad_final_project_fall21/pages/Customer/home.dart';
import 'package:ooad_final_project_fall21/pages/Customer/notification.dart';
import 'package:ooad_final_project_fall21/pages/Customer/profile.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';

class RootApp extends StatefulWidget {
  final Customer myCustomer;
  const RootApp({Key? key, required this.myCustomer}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        HomePage(myCustomer: widget.myCustomer),
        CartPage(myCustomer: widget.myCustomer),
        NotificationPage(myCustomer: widget.myCustomer),
        ProfilePage(myCustomer: widget.myCustomer),
      ],
    );
  }

  Widget getFooter() {
    List iconItems = [
      "assets/icons/home_icon.svg",
      "assets/icons/order_icon.svg",
      "assets/icons/bell_icon.svg",
      "assets/icons/profile_icon.svg"
    ];
    List textItems = ["Home", "Order", "Notification", "Profile"];
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
          color: textWhite,
          border: Border(
              top: BorderSide(width: 2, color: textBlack.withOpacity(0.06)))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(iconItems.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    iconItems[index],
                    width: 22,
                    color: pageIndex == index ? primary : textBlack,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    textItems[index],
                    style: TextStyle(
                        fontSize: 10,
                        color: pageIndex == index ? primary : textBlack),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
