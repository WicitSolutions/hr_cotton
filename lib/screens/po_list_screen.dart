import 'package:flutter/material.dart';
import 'package:hr_cotton/screens/pdf_viewer_screen.dart';

import '../api/api.dart';
import '../routes/routes.dart';
import '../styles/inventories_screen_styles.dart';

class PoListScreen extends StatefulWidget {
  const PoListScreen({Key? key}) : super(key: key);

  @override
  State<PoListScreen> createState() => _PoListScreenState();
}

class _PoListScreenState extends State<PoListScreen> {
  Api instance = Api();
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    if(arguments.isNotEmpty) {
      instance = arguments['instance'];
      widgets = getPoLists(instance.poLists);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Orders List"),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, '/poListFiltersScreen', arguments: {"instance": instance});
              },
              style: InventoriesScreenStyles.filtersButtonStyle,
              icon: const Icon(Icons.filter_list)
          ),
        ],
        backgroundColor: const Color(0xFF0061A6),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Text("No of results: ${(widgets.length/2).round().toString()}", style: InventoriesScreenStyles.defaultTextStyles),
              ),
              const SizedBox(height: 10),
              widgets.isNotEmpty ?
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: widgets,
                ),
              )
                  : const Expanded(child: Center(child: Text("Nothing to show here.")))
            ],
          )
      ),
    );
  }

  List<Widget> getPoLists(List<dynamic> elements) {
    List<Widget> polists = [];
    if (elements.isNotEmpty) {
      for (var element in elements) {
        polists.add(
          poLayout(
            // Todo
            element['PONo'].toString(),
            element['PODate'].toString(),
            element['VendorName'].toString(),
            element['ShipToWarehouse'].toString(),
            element['DaysOnWater'].toString(),
            element['POAmount'].toString(),
            element['POUrl'].toString(),
            element['PackingListUrl'].toString(),
            element['DeliveryOrderUrl'].toString(),
          ),
        );
        polists.add(const SizedBox(height: 10));
      }
    }
    return polists;
  }

  Widget poLayout(String poNumber, String poDate, String vendorName, String shipToWarehouse, String daysOnWater, String amount,
      String poInvoiceUrl, String packingListUrl, String deliveryOrder) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF0C3880),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: const BoxDecoration(
              color: Color(0xFFF2F9FF),
              // color: const Color(0xFF0C3880),
              borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // invoiceNo.toString()
                    RichText(text: TextSpan(
                        text: "Po #",
                        style: const TextStyle(
                          fontFamily: "poppins",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0C3880),
                        ),
                        children: [
                          TextSpan(
                              text: poNumber.toString(),
                              style: const TextStyle(
                                fontFamily: "poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF6600),
                              )
                          ),
                        ]
                    )),
                    Text(
                      poDate.toString(),
                      style: const TextStyle(
                          fontFamily: "poppins",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0C3880)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Color(0xFF0C3880)),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 3),
                  Text(
                    vendorName.toString(),
                    style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF747474)
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Ship To Warehouse: $shipToWarehouse",
                    style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF747474)
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(text: TextSpan(
                          text: "Days On Water: ",
                          style: const TextStyle(
                              fontFamily: "poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black
                          ),
                          children: [
                            TextSpan(
                                text: daysOnWater.toString(),
                                style: const TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            ),
                          ]
                      )),
                      RichText(text: TextSpan(
                          text: "Amount: ",
                          style: const TextStyle(
                              fontFamily: "poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black
                          ),
                          children: [
                            TextSpan(
                                text: amount.toString(),
                                style: const TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            ),
                          ]
                      )),
                    ],
                  ),
                  const SizedBox(height: 3),
                  const Divider(thickness: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                            elevation: MaterialStatePropertyAll(0)
                        ),
                        onPressed: () {
                          RoutingPage.goToNextPage(context: context, navigateTo: PdfViewer(
                              title: "Purchase Order",
                              documentUrl: poInvoiceUrl),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.picture_as_pdf_outlined, color: Colors.blueAccent, size: 20), // Color(0xFF0061A6)
                            Text("Purchase Order", style: TextStyle(
                                fontSize: 7,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold
                            )),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                            elevation: MaterialStatePropertyAll(0)
                        ),
                        onPressed: () {
                          RoutingPage.goToNextPage(context: context, navigateTo: PdfViewer(
                              title: "Packing List",
                              documentUrl: packingListUrl)
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.picture_as_pdf_outlined, color: Colors.blueAccent, size: 20),// Color(0xFF0061A6)
                            Text("Packing List", style: TextStyle(
                                fontSize: 7,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold
                            )),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                            elevation: MaterialStatePropertyAll(0)
                        ),
                        onPressed: () {
                          RoutingPage.goToNextPage(context: context, navigateTo: PdfViewer(
                              title: "Delivery Order",
                              documentUrl: deliveryOrder)
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.picture_as_pdf_outlined, color: Colors.blueAccent, size: 20),// Color(0xFF0061A6)
                            Text("Delivery Order", style: TextStyle(
                                fontSize: 7,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
