import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_cotton/api/storageSharedPrefrences.dart';
import 'package:hr_cotton/screens/inventories_screen.dart';
import 'package:hr_cotton/screens/login_screen.dart';
import 'package:hr_cotton/screens/pdf_viewer_screen.dart';
import 'package:hr_cotton/screens/po_list_screen.dart';
import 'package:hr_cotton/screens/sales_invoices_screen.dart';
import 'package:hr_cotton/svgs/svg_images.dart';
import 'package:hr_cotton/widgets/custom_grid_tile.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import '404_Screen.dart';
import 'customer_balance_screen.dart';
import 'inventory_filters_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage storage = LocalStorage('hr_cotton_app');

  @override
  void initState() {
    super.initState();
    print("Home Screen");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF212224),
      statusBarIconBrightness: Brightness.light,
    ));
  }

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
                    fontFamily: "poppins",
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
        color: Color(0xFF0061A6), // 0xFF1F9978
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      fontFamily: "poppins",
                    ),
                  ),
                  Text(
                    "Last Login: ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()).toString()}",
                    style: const TextStyle(
                      color: Color(0xFFC3C3C3),
                      fontWeight: FontWeight.normal,
                      fontSize: 11,
                      fontFamily: "poppins",
                    ),
                  ),
                ],
              ),
              /*IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                color: Colors.black,
                splashColor: Colors.white,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 30,
                ),
                alignment: Alignment.centerRight,
              ),*/
              PopupMenuButton<int>(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Logout"),
                        ],
                      ),
                    ),
                  ],
                iconSize: 30,
                // offset: const Offset(-25, 0),
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  if(value == 1) {
                    Navigator.pushReplacementNamed(context, "/");
                  }
                },

              ),
            ],
          )
        ),
      ),
    );
  }

  /*CircleAvatar(
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
              ),*/

  @override
  Widget build(BuildContext context) {
    SPStorage.printIsLoggedIn("Home Screen");

    var tilesData = [
      {
        "color": const Color(0xFFF0715E),
        "svgImage": SvgImages.inventories,
        "title": "Inventories",
        "route": const InventoriesScreen(),
      },
      {
        "color": const Color(0xFF1F9978),
        "svgImage": SvgImages.customerCenter2,
        "title": "Cust. Balance",
        "route": const CustomerBalanceScreen(),
      },
      {
        "color": const Color(0xFF344A5F),
        "svgImage": SvgImages.invoice2,
        "title": "Invoice List",
        "route": const SaleInvoicesScreen(),
      },
      {
        "color": const Color(0xFFFEB453),
        "svgImage": SvgImages.customerPoList2,
        "title": "PO List",
        "route": const PoListScreen(),
      },
      /*{
        "svgImage": SvgImages.poList,
        "title": "PO Lists",
        "route": const FilterPanel(),
      },*/
      {
        "color": const Color(0xFF579ED6),
        "svgImage": SvgImages.logout2,
        "title": "Logout",
        "route": const Text("Testing"),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0061A6),
      body: Center(
        child: SafeArea(
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                buildAppBar(),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -3),
                          spreadRadius: 3,
                          blurRadius: 10,
                          color: Colors.black12
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView(
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
                                color: tilesData[index]['color'] as Color,
                                title: tilesData[index]['title'].toString(),
                                svgImage: "assets${tilesData[index]['svgImage'].toString()}",
                                route: tilesData[index]["route"] as Widget,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
