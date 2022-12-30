import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hr_cotton/colors/app_colors.dart';
import '../widgets/custom_multi_select.dart';

class FilterPanel extends StatefulWidget {
  const FilterPanel({Key? key}) : super(key: key);

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    List<List<dynamic>> filters = arguments['instance'].filters;
    Map<String, String> warehouses = {},
        foodServices = {},
        healthCare = {},
        hospitality = {},
        automotive = {},
        ycmaGymGt = {},
        promotionalTowel = {},
        vendors = {},
        itemCodes = {};

    List<int> whIds = [],
        fsIds = [],
        hcIds = [],
        hIds = [],
        aIds = [],
        ycmaIds = [],
        ptIds = [],
        vIds = [],
        icIds = [];
    int count = 0;
    for (List<dynamic> filter in filters) {
      for (dynamic filterType in filter) {
        if (count == 0) warehouses[filterType['WareHouseId']] = filterType['WareHouseCode'];
        if (count == 1) foodServices[filterType['ItemCategoryId']] = filterType['ItemCategory'];
        if (count == 2) healthCare[filterType['ItemCategoryId']] = filterType['ItemCategory'];
        if (count == 3) hospitality[filterType['ItemCategoryId']] = filterType['ItemCategory'];
        if (count == 4) automotive[filterType['ItemCategoryId']] = filterType['ItemCategory'];
        if (count == 5) ycmaGymGt[filterType['ItemCategoryId']] = filterType['ItemCategory'];
        if (count == 6) promotionalTowel[filterType['ItemCategoryId']] = filterType['ItemCategory'];
        if (count == 7) vendors[filterType['VendorId']] = filterType['VendorName'];
        if (count == 8) itemCodes[filterType['ItemId']] = filterType['ItemCode'];
      }
      count++;
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Filters",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          fontSize: 30,
                        ),
                      ),
                      MaterialButton(
                        color: AppColors.facebookColor,
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/inventories",
                              arguments: [
                                whIds.isNotEmpty ? whIds : null,
                                fsIds.isNotEmpty ? fsIds : null,
                                hcIds.isNotEmpty ? hcIds : null,
                                hIds.isNotEmpty ? hIds : null,
                                aIds.isNotEmpty ? aIds : null,
                                ycmaIds.isNotEmpty ? ycmaIds : null,
                                ptIds.isNotEmpty ? ptIds : null,
                                vIds.isNotEmpty ? vIds : null,
                                icIds.isNotEmpty ? icIds : null
                              ]);
                          // Navigator.pop(context);
                        },
                        height: 35,
                        elevation: 0,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        child: const Text(
                          "Fetch",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomSelect(
                    items: warehouses,
                    title: "Warehouses",
                    onConfirm: (results) {
                      results.forEach((element) {
                        whIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: foodServices,
                    title: "Food Services",
                    onConfirm: (results) {
                      results.forEach((element) {
                        fsIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: healthCare,
                    title: "Health Care",
                    onConfirm: (results) {
                      results.forEach((element) {
                        hcIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: hospitality,
                    title: "Hospitality",
                    onConfirm: (results) {
                      results.forEach((element) {
                        hIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: automotive,
                    title: "Automotive",
                    onConfirm: (results) {
                      results.forEach((element) {
                        aIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: ycmaGymGt,
                    title: "YMCA/ GYM/ Golf Towel",
                    onConfirm: (results) {
                      results.forEach((element) {
                        ycmaIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: promotionalTowel,
                    title: "Promotional Towel",
                    onConfirm: (results) {
                      results.forEach((element) {
                        ptIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: vendors,
                    title: "Vendors",
                    onConfirm: (results) {
                      results.forEach((element) {
                        vIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomSelect(
                    items: itemCodes,
                    title: "Item Codes",
                    onConfirm: (results) {
                      results.forEach((element) {
                        icIds.add(int.parse(element));
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      // hintText: "Search",
                      label: Text("Description"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    style: TextStyle(height: 1),
                  ),
                  // buildBottomPart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
