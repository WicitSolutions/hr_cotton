import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../colors/app_colors.dart';
import '../widgets/custom_multi_select.dart';

class PoListFiltersScreen extends StatefulWidget {
  const PoListFiltersScreen({Key? key}) : super(key: key);

  @override
  State<PoListFiltersScreen> createState() => _PoListFiltersScreenState();
}

class _PoListFiltersScreenState extends State<PoListFiltersScreen> {
  bool isClicked = false,isDateRangeSelected = false;
  List<List<dynamic>> filters = [];
  Map<String, String> vendors = {}, customers = {}, ponumbers = {}, containernos = {}, shiptowarehouse = {}, itemcodes = {}, potypes = {};
  List<int> vIds = [], cIds = [], pIds = [], cnIds = [], swIds = [], icIds = [], ptIds = [];
  List<String> sVIds = [], sCIds = [], sPIds = [], sCnIds = [], sSwIds = [], sIcIds = [], sPtIds = [];
  String fromDate = "", toDate = "", status = "Open";
  late SharedPreferences preferences;

  @override
  void initState() {
    loadSavedFilters();
    super.initState();
  }

  void loadSavedFilters() async {
    preferences = await SharedPreferences.getInstance();
    sVIds = preferences.getStringList("s_vIds") ?? [];
    sCIds = preferences.getStringList("s_cIds") ?? [];
    sPIds = preferences.getStringList("s_pIds") ?? [];
    sCnIds = preferences.getStringList("s_cnIds") ?? [];
    sSwIds = preferences.getStringList("s_swIds") ?? [];
    sIcIds = preferences.getStringList("s_icIds") ?? [];
    sPtIds = preferences.getStringList("s_ptIds") ?? [];
  }

  void saveFilters(List<int> arr, String keyName) {
    if (arr.isNotEmpty) {
      List<String> tempArr = [];
      for (var element in arr) {
        tempArr.add(element.toString());
      }
      preferences.setStringList(keyName, tempArr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    Api instance = arguments['instance'];
    int count = 0;

    // getPoListFilters
    return WillPopScope(
        child: Scaffold(
          body: FutureBuilder<String>(
            future: instance.getPoListFilters(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                filters = instance.poListFilters;
                for (List<dynamic> filter in filters) {
                  for (dynamic filterType in filter) {
                    if (count == 0) vendors[filterType['VendorId']] = filterType['VendorName'];
                    if (count == 1) customers[filterType['CustomerId']] = filterType['CustomerName'];
                    if (count == 2) ponumbers[filterType['PurchaseOrderId']] = filterType['PONo'];
                    if (count == 3) containernos[filterType['PurchaseOrderId']] = filterType['ContainerNo'];
                    if (count == 4) shiptowarehouse[filterType['WareHouseId']] = filterType['WareHouseCode'];
                    if (count == 5) itemcodes[filterType['ItemId']] = filterType['ItemCode'];
                    if (count == 6) potypes[filterType['POTypeId']] = filterType['POType'];
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
                                  setState(() {
                                    isClicked = true;
                                  });

                                  saveFilters(vIds, "s_vIds");
                                  saveFilters(cIds, "s_cIds");
                                  saveFilters(pIds, "s_pIds");
                                  saveFilters(cnIds, "s_cnIds");
                                  saveFilters(swIds, "s_swIds");
                                  saveFilters(icIds, "s_icIds");
                                  saveFilters(ptIds, "s_ptIds");
                                  preferences.setString("s_status", status);
                                  preferences.setString("s_fromDate", fromDate);
                                  preferences.setString("s_toDate", toDate);

                                  await instance.getPoLists([
                                    vIds.isNotEmpty ? vIds : null,
                                    cIds.isNotEmpty ? cIds : null,
                                    pIds.isNotEmpty ? pIds : null,
                                    cnIds.isNotEmpty ? cnIds : null,
                                    swIds.isNotEmpty ? swIds : null,
                                    icIds.isNotEmpty ? icIds : null,
                                    ptIds.isNotEmpty ? ptIds : null,
                                    status.isNotEmpty ? status.toString() : null,
                                    fromDate.isNotEmpty ? fromDate.toString() : null,
                                    toDate.isNotEmpty ? toDate.toString() : null,
                                  ]);
                                  Navigator.pushReplacementNamed(context, "/poListScreen", arguments: {"instance": instance});
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

                                  const SizedBox(height: 10),
                                  CustomSelect(
                                    items: vendors,
                                    title: "Vendors",
                                    selectedValues: sVIds,
                                    onConfirm: (results) {
                                      results.forEach((element) {
                                        vIds.add(int.parse(element));
                                        /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomSelect(
                                    items: customers,
                                    title: "Customers",
                                    selectedValues: sCIds,
                                    onConfirm: (results) {
                                      results.forEach((element) {
                                        cIds.add(int.parse(element));
                                        /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomSelect(
                                    items: ponumbers,
                                    title: "Po Numbers",
                                    selectedValues: sPIds,
                                    onConfirm: (results) {
                                      results.forEach((element) {
                                        pIds.add(int.parse(element));
                                        /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomSelect(
                                    items: containernos,
                                    title: "Container Numbers",
                                    selectedValues: sCnIds,
                                    onConfirm: (results) {
                                      results.forEach((element) {
                                        cnIds.add(int.parse(element));
                                        /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomSelect(
                                    items: shiptowarehouse,
                                    title: "Warehouse",
                                    selectedValues: sSwIds,
                                    onConfirm: (results) {
                                      results.forEach((element) {
                                        swIds.add(int.parse(element));
                                        /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomSelect(
                                    items: itemcodes,
                                    title: "Item Codes",
                                    selectedValues: sIcIds,
                                    onConfirm: (results) {
                                      results.forEach((element) {
                                        icIds.add(int.parse(element));
                                        /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomSelect(
                                    items: potypes,
                                    title: "PO Types",
                                    selectedValues: sPtIds,
                                    onConfirm: (results) {
                                      results.forEach((element) {
                                        ptIds.add(int.parse(element));
                                        /*storage.dispose();
                                    storage.setItem("icIds", icIds);*/
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                      onPressed: () async {
                                        int currYear = DateTime.now().year;
                                        DateTimeRange? newDateRange = await showDateRangePicker(
                                          context: context,
                                          firstDate: DateTime(currYear - 5),
                                          lastDate: DateTime(currYear + 5),
                                          confirmText: "Save",
                                          cancelText: "Cancel",
                                          currentDate: DateTime.now(),
                                          builder: (context, child) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints(
                                                      maxWidth: 300.0,
                                                      maxHeight: 500.0
                                                  ),
                                                  child: child,
                                                )
                                              ],
                                            );
                                          },
                                        );
                                        fromDate = "'${newDateRange?.start.year}-${newDateRange?.start.month}-${newDateRange?.start.day}'";
                                        toDate = "'${newDateRange?.end.year}-${newDateRange?.end.month}-${newDateRange?.end.day}'";
                                        setState(() {
                                          fromDate != "" && toDate != "" ? isDateRangeSelected = true : isDateRangeSelected = false;
                                        });
                                      },
                                      child: const Text("Po Date")
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Radio(
                                              value: 'Open',
                                              groupValue: status,
                                              onChanged: (value) {
                                                setState(() {
                                                  status = value!;
                                                });
                                              }
                                          ),
                                          const Text("Open PO", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                              value: 'Received',
                                              groupValue: status,
                                              onChanged: (value) {
                                                setState(() {
                                                  status = value!;
                                                });
                                              }
                                          ),
                                          const Text("Received PO", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    )
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
            Navigator.pushReplacementNamed(context, "/poListScreen", arguments: {"instance": instance2});
          } else {
            Navigator.pushReplacementNamed(context, "/poListScreen", arguments: {"instance": instance2});
          }
          return false;
        }
    );
  }
}
