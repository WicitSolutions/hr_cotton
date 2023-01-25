import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../colors/app_colors.dart';
import '../widgets/custom_multi_select.dart';

class SalesInvoiceFiltersScreen extends StatefulWidget {
  const SalesInvoiceFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SalesInvoiceFiltersScreen> createState() => _SalesInvoiceFiltersScreenState();
}

class _SalesInvoiceFiltersScreenState extends State<SalesInvoiceFiltersScreen> {
  bool isClicked = false, isDateRangeSelected = false, isPending = false, isFinal = false, isDeleted = false,
      isAuto = false, isManual = false, isPaid = false, isUnpaid = false, isPartialPaid = false;
  List<List<dynamic>> filters = [];
  Map<String, String> customers = {}, warehouses = {}, salesInvoices = {}, poNumbers = {}, itemCodes = {}, contNos = {}, transactionPeriods = {}, salesReps = {};
  List<int> cIds = [], whIds = [], iIds = [], hIds = [], pIds = [], icIds = [], cnIds = [], eIds = [], sIds = [];
  List<String> amIds = [], psIds = [];
  List<String> sAmIds = [], sPsIds = [], sCIds = [], sWhIds = [], sIIds = [], sHIds = [], sPIds = [], sIcIds = [], sCnIds = [], sEIds = [], sSIds = [];
  String fromDate = "", toDate = "", isInvoiceDeleted = "0";
  late SharedPreferences preferences;

  @override
  void initState() {
    loadSavedFilters();
    super.initState();
  }

  void loadSavedFilters() async {
    preferences = await SharedPreferences.getInstance();
    sAmIds = preferences.getStringList("s_si_amIds") ?? [];
    sPsIds = preferences.getStringList("s_si_psIds") ?? [];
    sCIds = preferences.getStringList("s_si_cIds") ?? [];
    sWhIds = preferences.getStringList("s_si_whIds") ?? [];
    sIIds = preferences.getStringList("s_si_iIds") ?? [];
    sHIds = preferences.getStringList("s_si_hIds") ?? [];
    sPIds = preferences.getStringList("s_si_pIds") ?? [];
    sIcIds = preferences.getStringList("s_si_icIds") ?? [];
    sCnIds = preferences.getStringList("s_si_cnIds") ?? [];
    sEIds = preferences.getStringList("s_si_eIds") ?? [];
    sSIds = preferences.getStringList("s_si_sIds") ?? [];
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

    print("sCIds: $sCIds");

    return WillPopScope(
        child: Scaffold(
          body: FutureBuilder<String>(
            future: instance.getSaleInvoicesFilters(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                filters = instance.saleInvoicesFilters;
                for (List<dynamic> filter in filters) {
                  for (dynamic filterType in filter) {
                    if (count == 0) customers[filterType['CustomerId']] = filterType['CustomerName'];
                    if (count == 1) warehouses[filterType['WareHouseId']] = filterType['WareHouseCode'];
                    if (count == 2) salesInvoices[filterType['SalesInvoiceId']] = filterType['InvoiceNo'];
                    if (count == 3) poNumbers[filterType['SalesInvoicesIds']] = filterType['PONo'];
                    if (count == 4) itemCodes[filterType['ItemId']] = filterType['ItemCode'];
                    if (count == 5) contNos[filterType['PurchaseOrderId']] = filterType['PONo'];
                    if (count == 6) transactionPeriods[filterType['TransactionPeriodId']] = filterType['TransactionPeriod'];
                    if (count == 7) salesReps[filterType['EmployeeId']] = filterType['FullName'];
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

                                preferences.setStringList("s_si_amIds", amIds); // For String Arr
                                preferences.setStringList("s_si_psIds", psIds); // For String Arr
                                saveFilters(cIds, "s_si_cIds");
                                saveFilters(whIds, "s_si_whIds");
                                saveFilters(iIds, "s_si_iIds");
                                saveFilters(hIds, "s_si_hIds");
                                saveFilters(pIds, "s_si_pIds");
                                saveFilters(icIds, "s_si_icIds");
                                saveFilters(cnIds, "s_si_cnIds");
                                saveFilters(eIds, "s_si_eIds");
                                saveFilters(sIds, "s_si_sIds");

                                  await instance.getSaleInvoices([
                                  cIds.isNotEmpty ? cIds : null,
                                  whIds.isNotEmpty ? whIds : null,
                                  iIds.isNotEmpty ? iIds : null,
                                  hIds.isNotEmpty ? hIds : null,
                                  pIds.isNotEmpty ? pIds : null,
                                  icIds.isNotEmpty ? icIds : null,
                                  cnIds.isNotEmpty ? cnIds : null,
                                  eIds.isNotEmpty ? eIds : null,
                                  sIds.isNotEmpty ? sIds : null,
                                  amIds.isNotEmpty ? amIds : null,
                                  psIds.isNotEmpty ? psIds : null,
                                  fromDate.isNotEmpty ? fromDate.toString() : null,
                                  toDate.isNotEmpty ? toDate.toString() : null,
                                  isInvoiceDeleted.isNotEmpty ? isInvoiceDeleted.toString() : null
                                ]);

                                Navigator.pushReplacementNamed(context, "/saleInvoices", arguments: {"instance": instance});
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
                                items: warehouses,
                                title: "Warehouses",
                                selectedValues: sWhIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    whIds.add(int.parse(element));
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: salesInvoices,
                                title: "Sales Invoices",
                                selectedValues: sIIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    iIds.add(int.parse(element));
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: poNumbers,
                                title: "Po Numbers",
                                selectedValues: sPIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    pIds.add(int.parse(element));
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: itemCodes,
                                title: "item Codes",
                                selectedValues: sIcIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    icIds.add(int.parse(element));
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: contNos,
                                title: "Cont Nos",
                                selectedValues: sCnIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    cnIds.add(int.parse(element));
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: salesReps,
                                title: "Sales Reps",
                                selectedValues: sEIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    eIds.add(int.parse(element));
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: const {
                                  "0": "Pending",
                                  "1": "Final",
                                  "2": "Deleted",
                                },
                                title: "Status",
                                selectedValues: sSIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    if (element == '2') {
                                      isInvoiceDeleted = "1";
                                    } else {
                                      sIds.add(int.parse(element));
                                    }

                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: const {
                                  "auto": "Auto",
                                  "manual": "Manual",
                                },
                                title: "Auto/Manual",
                                selectedValues: sAmIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    amIds.add(element);
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomSelect(
                                items: const {
                                  "paid": "Paid",
                                  "unpaid": "Unpaid",
                                  "partialpaid": "Partial Paid",
                                },
                                title: "Payment Status",
                                selectedValues: sPsIds,
                                onConfirm: (results) {
                                  results.forEach((element) {
                                    psIds.add(element);
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
                                      isDateRangeSelected = true;
                                    });
                                  },
                                  child: const Text("Invoice Period")
                              ),
                              Center(
                                child: isDateRangeSelected ? Text("$fromDate to $toDate") : const Text(""),
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
            Navigator.pushReplacementNamed(context, "/saleInvoices", arguments: {"instance": instance2});
          } else {
            Navigator.pushReplacementNamed(context, "/saleInvoices", arguments: {"instance": instance2});
          }
          return false;
        }
    );
  }
}


/*Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: 1,
                                          child: Checkbox(
                                            value: isPending,
                                            onChanged: (value) {
                                              setState(() {
                                                isPending = value!;
                                              });
                                            },

                                          ),
                                        ),
                                        const Text("Pending", style: TextStyle(fontSize: 12)),
                                      ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(value: isFinal, onChanged: (value) {
                                        setState(() {
                                          isFinal = value!;
                                        });
                                      }),
                                      const Text("Final", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(value: isDeleted, onChanged: (value) {
                                        setState(() {
                                          isDeleted = value!;
                                        });
                                      }),
                                      const Text("Deleted", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),*/