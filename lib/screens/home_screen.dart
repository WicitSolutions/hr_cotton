import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_cotton/colors/app_colors.dart';
import 'package:hr_cotton/screens/inventories_screen.dart';
import 'package:hr_cotton/screens/login_screen.dart';
import 'package:hr_cotton/svgs/svg_images.dart';
import 'package:hr_cotton/widgets/custom_grid_tile.dart';
import 'filters_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*@override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFAFAFA),
      statusBarIconBrightness: Brightness.dark,
    ));
  }*/

  Widget buildAppBarOld() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0061A6),
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17

                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "umair@hrcotton.com",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14

                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "2022-12-07",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14

                ),
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Text(
                              "0",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12

                              ),
                            ),
                            Text(
                              "Invoices",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12

                              ),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          indent: 2,
                          endIndent: 2,
                          color: Colors.grey,
                          thickness: 1,
                          width: 0,
                        ),
                        Column(
                          children: const [
                            Text(
                              "3",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12

                              ),
                            ),
                            Text(
                              "POs",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12

                              ),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          indent: 2,
                          endIndent: 2,
                          color: Colors.grey,
                          thickness: 1,
                          width: 0,
                        ),
                        Column(
                          children: const [
                            Text(
                              "4",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                            ),
                            Text(
                              "Customer Pos",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                              ),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          indent: 2,
                          endIndent: 2,
                          color: Colors.grey,
                          thickness: 1,
                          width: 0,
                        ),
                        Column(
                          children: const [
                            Text(
                              "10",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12

                              ),
                            ),
                            Text(
                              "Items",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12

                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  // Color(0xFF0061A6),
  Widget buildAppBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0061A6),
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22

                ),
              ),
              CircleAvatar(
                radius: 25,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://static.vecteezy.com/system/resources/previews/002/002/403/large_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",
                      ),
                        fit: BoxFit.fill
                    ),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tilesData = [
      {
        "svgImage": SvgImages.warehouse,
        "title": "Inventories",
        "route": const InventoriesScreen(),
      },
      {
        "svgImage": SvgImages.invoice,
        "title": "Invoices",
        "route": const FilterPanel(),
      },
      {
        "svgImage": SvgImages.poList,
        "title": "PO Lists",
        "route": const FilterPanel(),
      },
      {
        "svgImage": SvgImages.customerPoList,
        "title": "Customers\nPOs",
        "route": const FilterPanel(),
      },
      {
        "svgImage": SvgImages.customerCenter,
        "title": "Customer\nCenter",
        "route": const FilterPanel(),
      },
      {
        "svgImage": SvgImages.logout,
        "title": "Logout",
        "route": const LoginScreen(),
      },
    ];

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: Column(
                children: [
                  buildAppBar(),
                  const SizedBox(height: 20),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        primary: true,
                        itemCount: tilesData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.2), // Change the height of the tiles
                            crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return CustomGridTile(
                            title: tilesData[index]['title'].toString(),
                            svgImage: "assets${tilesData[index]['svgImage'].toString()}",
                            route: tilesData[index]["route"] as Widget,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
