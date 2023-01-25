import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hr_cotton/colors/app_colors.dart';
import 'package:hr_cotton/screens/inventories_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';
import '../routes/routes.dart';
import '../styles/filter_screen_styles.dart';
import '../widgets/custom_multi_select.dart';

class InventoryFiltersScreen extends StatefulWidget {
  const InventoryFiltersScreen({Key? key}) : super(key: key);

  @override
  State<InventoryFiltersScreen> createState() => _InventoryFiltersScreenState();
}

class _InventoryFiltersScreenState extends State<InventoryFiltersScreen> {
  bool isClicked = false,
      isStockOnly = false,
      isStockOnlyAllItems = false,
      allItemsOnWater = false;
  List<List<dynamic>> filters = [];
  Map<String, String> warehouses = {}, foodServices = {}, healthCare = {}, hospitality = {}, automotive = {}, ycmaGymGt = {}, promotionalTowel = {}, vendors = {}, itemCodes = {};
  List<int> whIds = [], fsIds = [], hcIds = [], hIds = [], aIds = [], ycmaIds = [], ptIds = [], vIds = [], icIds = [];
  List<String> sWhIds = [], sFsIds = [], sHcIds = [], sHIds = [], sAIds = [], sYcmaIds = [], sPtIds = [], sVIds = [], sIcIds = [];
  String description = "";
  late SharedPreferences preferences;

  @override
  void initState(){
    loadSavedFilters();
    super.initState();
  }
  
  void loadSavedFilters() async {
    preferences = await SharedPreferences.getInstance();
    sWhIds = preferences.getStringList("s_whIds") ?? [];
    sFsIds = preferences.getStringList("s_fsIds") ?? [];
    sHcIds = preferences.getStringList("s_hcIds") ?? [];
    sHIds = preferences.getStringList("s_hIds") ?? [];
    sAIds = preferences.getStringList("s_aIds") ?? [];
    sYcmaIds = preferences.getStringList("s_ycmaIds") ?? [];
    sPtIds = preferences.getStringList("s_ptIds") ?? [];
    sVIds = preferences.getStringList("s_vIds") ?? [];
    sIcIds = preferences.getStringList("s_icIds") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Api instance = arguments['instance'];
    int count = 0;
    /*if (instance.inventories.isNotEmpty) {
      whIds = storage.getItem("whIds") != null ? storage.getItem("whIds").cast<int>() : [];
      fsIds = storage.getItem("fsIds") != null ? storage.getItem("fsIds").cast<int>() : [];
      hcIds = storage.getItem("hcIds") != null ? storage.getItem("hcIds").cast<int>() : [];
      hIds = storage.getItem("hIds") != null ? storage.getItem("hIds").cast<int>() : [];
      aIds = storage.getItem("aIds") != null ? storage.getItem("aIds").cast<int>() : [];
      ycmaIds = storage.getItem("ycmaIds") != null ? storage.getItem("ycmaIds").cast<int>() : [];
      ptIds = storage.getItem("ptIds") != null ? storage.getItem("ptIds").cast<int>() : [];
      vIds = storage.getItem("vIds") != null ? storage.getItem("vIds").cast<int>() : [];
      icIds = storage.getItem("icIds") != null ? storage.getItem("icIds").cast<int>() : [];
    }*/

    return WillPopScope(
      child: Scaffold(
        body: FutureBuilder<String>(
          future: instance.getInventoriesFilters(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              filters = instance.inventoriesFilters;
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
              return SafeArea(
                child: Padding(
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
                            onPressed: () async {
                              preferences = await SharedPreferences.getInstance();
                              setState(() {
                                isClicked = true;
                              });

                              if (whIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in whIds) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_whIds", tempWareHousesArr);
                              }
                              if (fsIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in fsIds) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_fsIds", tempWareHousesArr);
                              }
                              if (hcIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in hcIds) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_hcIds", tempWareHousesArr);
                              }
                              if (hIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in hIds) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_hIds", tempWareHousesArr);
                              }
                              if (aIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in aIds) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_aIds", tempWareHousesArr);
                              }
                              if (ycmaIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in ycmaIds ) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_ycmaIds", tempWareHousesArr);
                              }
                              if (ptIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in ptIds) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_ptIds", tempWareHousesArr);
                              }
                              if (vIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in vIds ) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_vIds", tempWareHousesArr);
                              }
                              if (icIds.isNotEmpty) {
                                List<String> tempWareHousesArr = [];
                                for (var element in icIds) {
                                  tempWareHousesArr.add(element.toString());
                                }
                                preferences.setStringList("s_icIds", tempWareHousesArr);
                              }

                              await instance.getInventories([
                                whIds.isNotEmpty ? whIds : null,
                                fsIds.isNotEmpty ? fsIds : null,
                                hcIds.isNotEmpty ? hcIds : null,
                                hIds.isNotEmpty ? hIds : null,
                                aIds.isNotEmpty ? aIds : null,
                                ycmaIds.isNotEmpty ? ycmaIds : null,
                                ptIds.isNotEmpty ? ptIds : null,
                                vIds.isNotEmpty ? vIds : null,
                                icIds.isNotEmpty ? icIds : null,
                                description.isNotEmpty ? description : null,
                                isStockOnly == false ? '0' : '1',
                                isStockOnlyAllItems == false ? '0' : '1',
                                allItemsOnWater == false ? '0' : '1'
                              ]);
                              Navigator.pushReplacementNamed(
                                  context, "/inventories",
                                  arguments: {"instance": instance});
                            },
                            height: 35,
                            elevation: 0,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            child: !isClicked
                                ? const Text(
                                    "Fetch",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 5,
                                  ),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            const SizedBox(height: 30),
                            CustomSelect(
                              items: warehouses,
                              title: "Warehouses",
                              selectedValues: sWhIds,
                              onConfirm: (results) {
                                results.forEach((element) {
                                  whIds.add(int.parse(element));
                                  /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomSelect(
                              items: foodServices,
                              title: "Food Services",
                              selectedValues: sFsIds,
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
                              selectedValues: sHcIds,
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
                              selectedValues: sHIds,
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
                              selectedValues: sAIds,
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
                              selectedValues: sYcmaIds,
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
                              selectedValues: sPtIds,
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
                              selectedValues: sVIds,
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
                              selectedValues: sIcIds,
                              onConfirm: (results) {
                                results.forEach((element) {
                                  icIds.add(int.parse(element));
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                label: Text("Description"),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              style: const TextStyle(height: 1),
                              onSubmitted: (result) {
                                description = result;
                              },
                            ),
                            Row(
                              children: [
                                const Text("Is Stock Only",
                                    style:
                                        FilterScreenStyles.checkBoxTextStyles),
                                const SizedBox(width: 10),
                                Checkbox(
                                    value: isStockOnly,
                                    onChanged: (value) {
                                      setState(() {
                                        isStockOnly = value!;
                                      });
                                    })
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Is Stock Only All Items",
                                    style:
                                        FilterScreenStyles.checkBoxTextStyles),
                                const SizedBox(width: 10),
                                Checkbox(
                                    value: isStockOnlyAllItems,
                                    onChanged: (value) {
                                      setState(() {
                                        isStockOnlyAllItems = value!;
                                      });
                                    })
                              ],
                            ),
                            Row(
                              children: [
                                const Text("All Items On Water",
                                    style:
                                        FilterScreenStyles.checkBoxTextStyles),
                                const SizedBox(width: 10),
                                Checkbox(
                                    value: allItemsOnWater,
                                    onChanged: (value) {
                                      setState(() {
                                        allItemsOnWater = value!;
                                      });
                                      print(
                                          "allItemsOnWater: $allItemsOnWater");
                                    })
                              ],
                            )
                          ],
                        ),
                      )
                      // buildBottomPart(),
                    ],
                  ),
                ),
              );
            }
            return Center(
                child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0061A6),
              ),
              child: Dialog(
                child: SizedBox(
                  height: 150,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SpinKitRing(
                        color: Colors.blueAccent,
                        size: 50.0,
                      ),
                      SizedBox(height: 10),
                      Text("Please wait loading!!!"),
                    ],
                  ),
                ),
              ),
            ));
          },
        ),
      ),
      onWillPop: () async {
        Api instance2 = Api();
        if (instance.inventories.isNotEmpty) {
          instance2.inventories = instance.inventories;
          Navigator.pushReplacementNamed(context, "/inventories", arguments: {"instance": instance2});
        } else {
          Navigator.pushReplacementNamed(context, "/inventories", arguments: {"instance": instance2});
        }
        return false;
      },
    );
  }
}

/*FutureBuilder(
          future: instance.getFilters(),
          builder: (context, AsyncSnapshot<String> snapshot) => {},
        ),*/
