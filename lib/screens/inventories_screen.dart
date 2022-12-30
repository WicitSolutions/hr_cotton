import 'package:flutter/material.dart';

import '../api/API.dart';
import '../styles/inventories_screen_styles.dart';

class InventoriesScreen extends StatefulWidget {
  const InventoriesScreen({Key? key}) : super(key: key);

  @override
  State<InventoriesScreen> createState() => _InventoriesScreenState();
}

class _InventoriesScreenState extends State<InventoriesScreen> {
  API instance = API();
  Map<String, int> warehouses = {
    "Atlanta": 10,
    "Dallas": 20,
    "HOUSTON": 30,
    "RIVERSIDE": 40,
    "ONTARIO": 50,
    "OHIO 1": 60,
    "OHIO CEV": 70,
    "In Stock Only": 80,
    "In Stock Only All Items": 90,
    "All Items On Water": 100,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpFilters();
  }

  List<Widget> getWarehouses(Map<String, int> warehouses) {
    List<Widget> warehousesCards = [];
    warehouses.forEach((key, value) {
      warehousesCards.add(warehouseLayout(key, value));
    });
    return warehousesCards;
  }

  List<Widget> getInventories(List<dynamic> elements) {
    List<Widget> inventories = [];
    for (var element in elements) {
      inventories.add(inventoryLayout(
          element['ItemCode'],
          element['Description'],
          element['QtyOnHand'],
          element['TotalIncoming'],
          "30", "0")
      );
      inventories.add(const SizedBox(height: 10));
    }
    print("Get Inventories ${inventories.length}");
    return inventories;
  }

  Widget warehouseLayout(String warehouse, int qty) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Expanded(
          flex: 6,
          child: Text(warehouse),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 4,
          child: Text(qty.toString()),
        ),
      ],
    );
  }

  void setUpFilters() async {
    await instance.getFilters();
  }

  void setUpInventories(List<dynamic> args) async {
    await instance.getInventories(args);
    print("Setup Inventories: ${instance.inventories.length}");
  }

  Widget inventoryLayout(String itemCode, String itemDesc, String stockQty,
      String totalIncome, String totalStock, String totalIncoming) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(itemCode),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(itemDesc),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(stockQty),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(totalIncome),
          ),
          const Divider(color: Colors.black, thickness: 3, height: 0),
          IntrinsicHeight(
            child: Container(
              // padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: const [
                  SizedBox(width: 5),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "WAREHOUSE",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // SizedBox(width: 10),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 0,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "QTY",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black, thickness: 3, height: 0),
          SizedBox(
            height: 65,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: getWarehouses(warehouses),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffe1e1ff),
            ),
            child: Row(
              children: [
                const SizedBox(width: 5),
                const Expanded(
                  flex: 6,
                  child: Text("Total Stock"),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: Text(totalStock),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.black, thickness: 3, height: 0),
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: const Center(
              child: Text(
                "WAREHOUSE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.black, thickness: 3, height: 0),
          IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "PO#",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Text(
                        "PO Date",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "QTY",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black, thickness: 3, height: 0),
          const Divider(color: Colors.black, thickness: 3, height: 0),
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
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <List<int>>[]) as List;
    List<Widget> widgets = [];
    setUpInventories(arguments);
    setState(() {
      widgets = getInventories(instance.inventories);
    });
    print("Arguments: ${arguments.length}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventories"),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/filters',
                  arguments: {"instance": instance});
              /*RoutingPage.goToNextPage(
                context: context,
                navigateTo: const FilterPanel(),
              );*/
            },
            style: InventoriesScreenStyles.filtersButtonStyle,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  label: Text("Search"),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                style: TextStyle(height: 1),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                // children: getInventories(5),
                children: widgets,
              ),
            )
          ],
        ),
      ),
    );
  }
}
