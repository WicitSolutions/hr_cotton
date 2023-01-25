import 'package:flutter/material.dart';
import 'package:hr_cotton/routes/routes.dart';
import 'package:hr_cotton/screens/pdf_viewer_screen.dart';

import '../api/api.dart';
import '../styles/inventories_screen_styles.dart';
import '../styles/sale_invoices_screen_styles.dart';

class SaleInvoicesScreen extends StatefulWidget {
  const SaleInvoicesScreen({Key? key}) : super(key: key);

  @override
  State<SaleInvoicesScreen> createState() => _SaleInvoicesScreenState();
}

class _SaleInvoicesScreenState extends State<SaleInvoicesScreen> {
  Api instance = Api();
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    if(arguments.isNotEmpty) {
      instance = arguments['instance'];
      widgets = getSalesInvoices(instance.saleInvoices);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale Invoices"),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, '/saleInvoicesFilters', arguments: {"instance": instance});
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
                // children: getInventories(5),
                children: widgets,
              ),
            )
                : const Expanded(child: Center(child: Text("Nothing to show here.")))
          ],
        ),
      ),
    );
  }

  List<Widget> getSalesInvoices(List<dynamic> elements) {
    List<Widget> salesInvoices = [];
    if (elements.isNotEmpty) {
      for (var element in elements) {
        salesInvoices.add(
          saleInvoiceLayout(
            element['InvoiceNo'].toString(),
            element['InvoiceDate'].toString(),
            element['CustomerName'].toString(),
            element['ShipToName'].toString(),
            element['PONo'].toString(),
            element['InvoiceAmount'].toString(),
            element['InvoiceUrl'].toString(),
            element['PackingListUrl'].toString(),
            element['BillOfLadingUrl'].toString(),
            element['ReleaseOrderUrl'].toString(),
          ),
        );
        salesInvoices.add(const SizedBox(height: 10));
      }
    }
    return salesInvoices;
  }

  Widget saleInvoiceLayout(String invoiceNo, String invoiceDate, String customerName, String shipToName, String poNo, String invoiceAmount,
      String InvoiceUrl, String PackingListUrl, String BillOfLadingUrl, String ReleaseOrderUrl) {
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
                      text: "INV # ",
                      style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0C3880),
                      ),
                      children: [
                        TextSpan(
                          text: invoiceNo.toString(),
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
                      invoiceDate.toString(),
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
                    customerName.toString(),
                    style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF747474)
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Ship To Name: $shipToName",
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
                          text: "Po No: ",
                          style: const TextStyle(
                              fontFamily: "poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black
                          ),
                          children: [
                            TextSpan(
                                text: poNo.toString(),
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
                                text: invoiceAmount.toString(),
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
                              title: "Sale Invoice",
                              documentUrl: InvoiceUrl),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.picture_as_pdf_outlined, color: Colors.blueAccent, size: 20), // Color(0xFF0061A6)
                            Text("Sale Invoice", style: TextStyle(
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
                              documentUrl: PackingListUrl)
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
                          print("BillOfLadingUrl: $BillOfLadingUrl");
                          RoutingPage.goToNextPage(context: context, navigateTo: PdfViewer(
                              title: "Bill of lading",
                              documentUrl: BillOfLadingUrl)
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.picture_as_pdf_outlined, color: Colors.blueAccent, size: 20),// Color(0xFF0061A6)
                            Text("Bill of lading", style: TextStyle(
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
                              title: "Release Order",
                              documentUrl: ReleaseOrderUrl)
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.picture_as_pdf_outlined, color: Colors.blueAccent, size: 20), // Color(0xFF0061A6)
                            Text("Release Order", style: TextStyle(
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

  Widget saleInvoiceTableLayout (List<dynamic> elements) {
    List<Widget> invoiceNos = [], rightSideWidgets = [];
    invoiceNos.add(const Text(
      "Invoices",
      style: TextStyle(
        fontFamily: "poppins",
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    )
    );
    rightSideWidgets.add(
      Row(
        children: const [
          Text(
            "Invoice Date",
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Customer Name",
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Ship To Name",
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "PO No",
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Invoice Amount",
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );

    List<DataRow> dataRows = [];

    /*for (int i = 0; i <= elements.length; i++) {
      dataRows.add(
          DataRow(
            cells: [
            DataCell(Text(elements[i]['InvoiceNo'].toString())),
            DataCell(Text(elements[i]['InvoiceDate'].toString())),
            DataCell(Text(elements[i]['CustomerName'].toString())),
            DataCell(Text(elements[i]['ShipToName'].toString())),
            DataCell(Text(elements[i]['PONo'].toString())),
            DataCell(Text(elements[i]['InvoiceAmount'].toString())),
          ],
            color: i %2 == 0 ? const MaterialStatePropertyAll(Colors.blueAccent) : const MaterialStatePropertyAll(Colors.grey),
          )
      );
    }*/

    for (var element in elements) {
      dataRows.add(
        DataRow(cells: [
          DataCell(Text(element['InvoiceNo'].toString(), style: SaleInvoicesScreenStyles.tableRowsStyle)),
          DataCell(Text(element['InvoiceDate'].toString(), style: SaleInvoicesScreenStyles.tableRowsStyle)),
          DataCell(Text(element['CustomerName'].toString(), style: SaleInvoicesScreenStyles.tableRowsStyle)),
          DataCell(Text(element['ShipToName'].toString(), style: SaleInvoicesScreenStyles.tableRowsStyle)),
          DataCell(Text(element['PONo'].toString(), style: SaleInvoicesScreenStyles.tableRowsStyle)),
          DataCell(Text(element['InvoiceAmount'].toString(), style: SaleInvoicesScreenStyles.tableRowsStyle)),
        ],
        )
      );
    }

     /*return Expanded(
       child: HorizontalDataTable(
         leftHandSideColumnWidth: 100,
         rightHandSideColumnWidth: 600,
         leftSideChildren: invoiceNos,
         rightSideChildren: rightSideWidgets,
         itemCount: elements.length,
         scrollPhysics: const BouncingScrollPhysics(),
       ),
     );*/
    return SingleChildScrollView (
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10,
        headingRowColor: const MaterialStatePropertyAll(Colors.blueAccent),
        columns: const [
           DataColumn(label: Text(
             "Invoices",
             style: SaleInvoicesScreenStyles.tableHeadersStyle,
           )),
           DataColumn(label: Text(
             "Invoice Date",
             style: SaleInvoicesScreenStyles.tableHeadersStyle,
           )),
           DataColumn(label: Text(
             "Customer Name",
             style: SaleInvoicesScreenStyles.tableHeadersStyle,
           )),
           DataColumn(label: Text(
             "Ship To Name",
             style: SaleInvoicesScreenStyles.tableHeadersStyle,
           )),
           DataColumn(label: Text(
             "PO No",
             style: SaleInvoicesScreenStyles.tableHeadersStyle,
           )),
           DataColumn(label: Text(
             "Invoice Amount",
             style: SaleInvoicesScreenStyles.tableHeadersStyle,
           )),
        ],
        rows: dataRows,
      ),
    );
  }
}
