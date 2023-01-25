import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../styles/inventories_screen_styles.dart';

class InventoriesScreen extends StatefulWidget {
  const InventoriesScreen({Key? key}) : super(key: key);

  @override
  State<InventoriesScreen> createState() => _InventoriesScreenState();
}

class _InventoriesScreenState extends State<InventoriesScreen> {
  Api instance = Api();
  List<String> itemInfo = [];
  Map<String, int> warehouses = {
    "Atlanta": 10,
    "Dallas": 20,
    "HOUSTON": 30,
    "RIVERSIDE": 40,
    "ONTARIO": 50,
    "OHIO 1": 60,
    "OHIO CEV": 70,
  };

  List<Widget> widgets = [], tempWidgets = [];

  final _controller = TextEditingController();

  List<Widget> getWarehouses(Map<String, int> warehouses) {
    List<Widget> warehousesCards = [];
    warehouses.forEach((key, value) {
      warehousesCards.add(warehouseLayout(key, value));
    });
    return warehousesCards;
  }

  List<Widget> getInventories(List<dynamic> elements) {
    List<Widget> inventories = [];
    if (elements.isNotEmpty) {
      for (var element in elements) {
        inventories.add(
          inventoryLayout(
              element['ItemCode'].toString(),
              element['Description'].toString(),
              element['QtyOnHand'].toString(),
              element['TotalIncoming'].toString(),
              "30", "0"
          ),
        );
        inventories.add(const SizedBox(height: 10));
      }
    }
    return inventories;
  }

  Widget warehouseLayout(String warehouse, int qty) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Expanded(
          flex: 6,
          child: Text(
              warehouse,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 4,
          child: Text(
            qty.toString(),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget inventoryLayout(String itemCode, String itemDesc, String stockQty, String totalIncome, String totalStock, String totalIncoming) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F9FF),
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
                color: Color(0xFF0C3880),
                borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      itemCode.toString(),
                      style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(
                  itemDesc.toString(),
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
                    Text("Qty On Hand: ${stockQty.toString()}"),
                    Text("Total Incoming: ${totalIncome.toString()}"),
                  ],
                ),
                const SizedBox(height: 3),
                const Divider(
                  endIndent: 3,
                  indent: 5,
                )
              ],
            ),
          ),
          // const Divider(color: Colors.black, thickness: 1, height: 0),
          Row(
            children: const [
              SizedBox(width: 5),
              Expanded(
                flex: 6,
                child: Text(
                  "WAREHOUSE",
                  style: TextStyle(
                    color: Color(0xFF438A98),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline
                  ),
                ),
              ),
              // SizedBox(width: 10),
              /*VerticalDivider(
                color: Colors.black,
                thickness: 2,
                width: 0,
              ),*/
              SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: Text(
                  "QTY",
                  style: TextStyle(
                      color: Color(0xFF438A98),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline
                  ),
                ),
              ),
            ],
          ),
          // const Divider(color: Colors.black, thickness: 1, height: 0),
          Column(
            children: getWarehouses(warehouses),
          ),
          Row(
            children: [
              const SizedBox(width: 5),
              const Expanded(
                flex: 6,
                child: Text(
                  "TOTAL STOCK",
                  style: TextStyle(
                    color: Color(0xFF438A98),
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: Text(
                  totalStock,
                  style: const TextStyle(
                      color: Color(0xFF438A98),
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(endIndent: 3, indent: 5, thickness: 0),
          const Center(
            child: Text(
                "INCOMING BREAKUP",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const Divider(endIndent: 3, indent: 5, thickness: 0),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "PO#",
                    style: TextStyle(
                        color: Color(0xFFFF6600),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Center(
                  child: Text(
                    "PO Date",
                    style: TextStyle(
                        color: Color(0xFFFF6600),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "QTY",
                    style: TextStyle(
                        color: Color(0xFFFF6600),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffe1e1ff),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Incoming"),
                  Text(totalIncoming),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    // List<Widget> widgets = [];
    if(arguments.isNotEmpty) {
      instance = arguments['instance'];
      widgets = getInventories(instance.inventories);
      // debugger();
      int index = 0;
      for (var element in instance.inventories) {
        itemInfo.add("${element['ItemCode']} ${element['Description']},${index.toString()}");
        index++;
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventories"),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/inventoryFilters', arguments: {"instance": instance});
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
              /*TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  label: const Text("Search"),
                  border:const  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                ),
                style: const TextStyle(height: 1),
                onSubmitted: (value) {
                  List<Widget> newWidgets = [];
                  if (itemInfo.isNotEmpty) {
                    for (var element in itemInfo) {
                      List<String> temp = element.split(',');
                      if(temp[0].toLowerCase().contains(value.toLowerCase())) {
                        int index = int.parse(temp[1]);
                        newWidgets.add(widgets[index]);
                      }
                    }
                    setState(() {
                      widgets.clear();
                      widgets.addAll(newWidgets);
                    });
                  }
                },
              )*/
            ),
            const SizedBox(height: 10),
            widgets.isNotEmpty ? 
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                // children: getInventories(5),
                children: widgets,
              ),
            ) :
            const Expanded(child: Center(child: Text("Nothing to show here."))
            )
          ],
        ),
      ),
    );
  }
}
