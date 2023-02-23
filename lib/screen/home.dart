import 'dart:io';

import 'package:billgenrater/pdf/file_handle_api.dart';
import 'package:billgenrater/pdf/pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../pdf/pdf_invoice_api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _singleValue = "Text alignment right";
  RadioModal _verticalGroupValue = RadioModal("A2G", "assets/a2g(2).png");

  final _status = <RadioModal>[
    RadioModal("A2G", "assets/a2g(2).png"),
    RadioModal("DMJ", "assets/image.png"),
    RadioModal("AHIT", "assets/ahit.png"),
    RadioModal("AHEC", "assets/AHEC logo.png"),
    RadioModal("AHUF", "assets/ahuf.png"),
    RadioModal("BBMSIT", "assets/BBMSIT.png"),
    RadioModal("UNIHUB", "assets/ukuni.jpeg")
  ];
  String image = "";
  List<double> priceList = [];
  final _invoiceControlller = TextEditingController();
  int count = 1;
  String? date;
  DateTime? picked = DateTime.now();
  List<ItemPrice> itemList = [];
  double heifht = 500;
  double total = 0;
  double subtotal = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "A2 Groups",
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ).p(10),
              ],
            ),
            30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Select Logo",
                        style: TextStyle(color: Colors.black, fontSize: 25))
                    .p(10),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 700,
                  child: RadioGroup<RadioModal>.builder(
                    horizontalAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    groupValue: _verticalGroupValue,
                    onChanged: (value) => setState(() {
                      _verticalGroupValue = value!;
                    }),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    items: _status,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item.title,
                    ),
                    fillColor: Colors.black,
                  ),
                ),
              ],
            ).pOnly(left: 5),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Invoice",
                        style: TextStyle(color: Colors.black, fontSize: 25))
                    .p(10),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: const Text(
                          "Customer Name",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        )),
                  ),
                ),
                20.widthBox,
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: const Text(
                          "Mobile No",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        )),
                  ),
                ),
              ],
            ).p(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: const Text(
                          "Customer Shipping Address",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        )),
                  ),
                ),
                20.widthBox,
                Expanded(
                  child: TextFormField(
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: const Text(
                          "Sold By Details",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        )),
                  ),
                ),
              ],
            ).p(10),
            30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(
                    child: Center(
                  child: Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                Expanded(
                    child: Center(
                  child: Text(
                    "Item Price",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                Expanded(
                    child: Center(
                  child: Text(
                    "Quantity",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                Expanded(
                    child: Center(
                  child: Text(
                    "Tax %",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                Expanded(
                    child: Center(
                  child: Text(
                    "Action",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              ],
            ).p(10),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
            ListView.builder(
                itemCount: count,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Tabs(
                    logic: (String dec, double amount, int qun, double tax) {
                      double a = amount * qun;
                      double b = tax / 2;
                      double d = a * 12;
                      double c = (a * (tax / 100));
                      double h = c / 2;
                      setState(() {
                        if (itemList.asMap().containsKey(index)) {
                          //if there is key,
                          itemList[index] = ItemPrice(dec, qun, b, b, a, h, h);
                          priceList[index] = a;
                          total = addvalue();
                          subtotal = total;
                        } else {
                          itemList.add(ItemPrice(
                            dec,
                            qun,
                            b,
                            b,
                            a,
                            h,
                            h,
                          ));
                          priceList.add(a);
                          total = addvalue();

                          subtotal = total;
                        }
                      });
                    },
                    tabIndex: index,
                    myAddTab: (value) {
                      setState(() {
                        count = value;
                        int a = value * 50;
                        heifht = a + heifht;
                      });
                    },
                    myRemoveTab: (value) {
                      setState(() {
                        count = value;
                        int a = value * 50;
                        heifht = heifht - a;
                        itemList.removeAt(index);
                        priceList.removeAt(index);
                        total = addvalue();
                        subtotal = total;
                      });
                    },
                    index: count,
                  ).pOnly(top: 10, bottom: 10);
                }),
            30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: const Text(
                          "Payment Method",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        )),
                  ),
                ),
                20.widthBox,
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: const Text(
                          "GSTIN",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        )),
                  ),
                ),
              ],
            ).p(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () async {
                    picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2016),
                      lastDate: DateTime(2030),
                    );

                    setState(() {
                      date = "${picked!.day}-${picked!.month}-${picked!.year}";
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.grey.shade600,
                          style: BorderStyle.solid),
                    ),
                    child: Center(
                      child: Text(
                        "Date: ${picked!.day}-${picked!.month}-${picked!.year}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ).p(10),
                )),
                Expanded(
                    child: TextFormField(
                  controller: _invoiceControlller,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      label: const Text(
                        "Invoice No",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black, style: BorderStyle.solid),
                      )),
                  onChanged: (_) {
                    setState(() {});
                  },
                ).p(9))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      label: const Text(
                        "Email Address:",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black, style: BorderStyle.solid),
                      )),
                ).p(9))
              ],
            ),
            30.heightBox,
            const Text(
              "Live Preview",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: heifht,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: Offset(4, 4),
                    )
                  ]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage(_verticalGroupValue.image))),
                        ).pOnly(left: 20),
                        Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "INVOICE",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ).p(10)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Invoice No:",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            5.widthBox,
                            Text(
                              _invoiceControlller.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                            10.widthBox,
                            const Text(
                              "Date",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            5.widthBox,
                            Text(
                              "${picked!.day} - ${picked!.month} - ${picked!.year}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ).pOnly(right: 10)
                          ],
                        )),
                      ],
                    ).pOnly(
                      top: 10,
                      bottom: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Invoice To:",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Pay To:",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ).pOnly(left: 10, right: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Receipt Summary",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ).p(10),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  30.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "${itemList[index].dec}"))
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("CGST: ${itemList[index].cgst}%")
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("SGST: ${itemList[index].cgst}%")
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "₹${itemList[index].amount}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      )),
                                    ],
                                  ).p(10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                         Text(
                                                  "Qty: ${itemList[index].qty}")
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "CGST Amount: ₹${itemList[index].cgstamount.toInt()}")
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "SGST Amount: ₹${itemList[index].cgstamount.toInt()}")
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Rate: ₹${itemList[index].amount - (itemList[index].cgstamount + itemList[index].cgstamount)}")
                                        ],
                                      )),
                                    ],
                                  ).p(10),
                                  Container(
                                    height: 10,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ).pOnly(left: 10, right: 10),
                                ],
                              )).p(10);
                        }),
                   
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Subtotal",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                70.widthBox,
                                Text(
                                  "₹$subtotal",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ).pOnly(right: 10)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Total",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                70.widthBox,
                                Text(
                                  "₹$total",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ).pOnly(right: 10)
                              ],
                            ),
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ).p(9),
            10.heightBox,
            ElevatedButton(onPressed:  ()async{
              final pdfFile = await PdfInvoiceApi.generate();
              // ignore: prefer_const_constructors
              Navigator.push(context, CupertinoPageRoute(builder: (context) => MyPdfViewr()));
            }, child: const Center(
                child: Text("Genrate"),
              ),),
          ],
        ).pOnly(left: 50, right: 50),
      ),
    );
  }

  addvalue() {
    double price = 0;
    for (int i = 0; i < priceList.length; i++) {
      price = price + priceList[i];
    }
    return price;
  }
}

class Tabs extends StatefulWidget {
  final Function myAddTab;
  final Function myRemoveTab;
  final int tabIndex;
  final int index;
  final Function logic;
  const Tabs(
      {Key? key,
      required this.myAddTab,
      required this.index,
      required this.logic,
      required this.tabIndex,
      required this.myRemoveTab})
      : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  TextEditingController _descController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _qauntyController = TextEditingController();
  TextEditingController _taxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(4, 4),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
            controller: _descController,
            maxLines: 3,
            maxLength: 300,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ).p(4)),
          Expanded(
              child: TextField(
            controller: _amountController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            onChanged: (value) {},
          ).p(4)),
          Expanded(
              child: TextField(
            controller: _qauntyController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            onChanged: (value) {},
          ).p(4)),
          Expanded(
              child: TextField(
            controller: _taxController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            onChanged: (value) {},
          ).p(4)),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: IconButton(
                      onPressed: () {
                        int value = widget.index + 1;
                        widget.myAddTab(value);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ))),
              10.widthBox,
              Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: IconButton(
                      onPressed: () {
                        if (widget.index != 1) {
                          int value = widget.index - 1;
                          widget.myRemoveTab(value);
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ))),
              10.widthBox,
              Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: IconButton(
                      onPressed: () {
                        String amount = _amountController.text;
                        String dec = _descController.text;
                        String tax = _taxController.text;
                        String quantity = _qauntyController.text;
                        double a = double.parse(amount);
                        int b = int.parse(quantity);
                        double c = double.parse(tax);
                        widget.logic(
                          dec,
                          a,
                          b,
                          c,
                        );
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ))),
            ],
          ).p(4)),
        ],
      ),
    );
  }
}

class ItemPrice {
  final String dec;
  final int qty;
  final double cgst;
  final double sgst;
  final double amount;
  final double cgstamount;
  final double sgstamount;

  ItemPrice(
    this.dec,
    this.qty,
    this.cgst,
    this.sgst,
    this.amount,
    this.cgstamount,
    this.sgstamount,
  );
}

class RadioModal {
  final String title;
  final String image;

  RadioModal(this.title, this.image);
}
