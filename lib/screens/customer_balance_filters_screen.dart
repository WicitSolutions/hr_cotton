import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../colors/app_colors.dart';
import '../widgets/custom_multi_select.dart';

class CustBalanceFiltersScreen extends StatefulWidget {
  const CustBalanceFiltersScreen({Key? key}) : super(key: key);

  @override
  State<CustBalanceFiltersScreen> createState() => _CustBalanceFiltersScreenState();
}

class _CustBalanceFiltersScreenState extends State<CustBalanceFiltersScreen> {
  bool isClicked = false;
  List<dynamic> filters = [];
  Map<String, String> customers = {};
  List<int> cIds = [];
  List<String> sCIds = [];
  String date = "";
  late SharedPreferences preferences;

  @override
  void initState() {
    loadSavedFilters();
    super.initState();
  }

  void loadSavedFilters() async {
    preferences = await SharedPreferences.getInstance();
    sCIds = preferences.getStringList("s_cIds") ?? [];
    date = preferences.getString("s_date") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    Api instance = arguments['instance'];
    int count = 0;

    return WillPopScope(
        child: Scaffold(
          body: FutureBuilder<String>(
            future: instance.getCustBalanceFilters(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  filters = instance.customers;
                  for (dynamic filter in filters) {
                    customers[filter['CustomerId']] = filter['CustomerName'];
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

                                    if (cIds.isNotEmpty) {
                                      List<String> tempWareHousesArr = [];
                                      for (var element in cIds) {
                                        tempWareHousesArr.add(element.toString());
                                      }
                                      preferences.setStringList("s_cIds", tempWareHousesArr);
                                    }
                                    if (date.isNotEmpty) {
                                      preferences.setString("s_date", date);
                                    }

                                    await instance.getCustomers([
                                      cIds.isNotEmpty ? cIds : null,
                                      date.isNotEmpty ? date.toString() : null,
                                    ]);
                                    Navigator.pushReplacementNamed(context, "/custBalanceScreen", arguments: {"instance": instance});
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
                                    ElevatedButton(
                                        onPressed: () async {
                                          int currYear = DateTime.now().year;
                                          DateTime? selectedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(currYear - 5),
                                              lastDate: DateTime(currYear + 5),
                                              confirmText: "Save",
                                              cancelText: "Cancel",
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
                                            }
                                          );
                                          setState(() {
                                            date = "'${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}'";
                                          });
                                          print(date);
                                        },
                                        child: const Text("As Of")
                                    ),
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
              }
          ),
        ),
        onWillPop: () async {
          Api instance2 = Api();
          if (instance.inventories.isNotEmpty) {
            instance2.inventories = instance.inventories;
            Navigator.pushReplacementNamed(context, "/custBalanceScreen", arguments: {"instance": instance2});
          } else {
            Navigator.pushReplacementNamed(context, "/custBalanceScreen", arguments: {"instance": instance2});
          }
          return false;
        }
    );
  }
}
