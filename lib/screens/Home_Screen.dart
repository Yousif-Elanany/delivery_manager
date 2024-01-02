import 'dart:collection';
import 'dart:math';

import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widget/Homescreen_Title.dart';
import 'package:delivery_manager/widget/add_bottom_sheet.dart';
import 'package:delivery_manager/widget/background.dart';
import 'package:delivery_manager/widget/chart_order.dart';
import 'package:delivery_manager/widget/orderitem.dart';
import 'package:delivery_manager/widget/sticky_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Homescreen extends StatefulWidget {
  final Function toggle;
  Homescreen(this.toggle);
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  SplayTreeMap<String, Map<String, dynamic>> orders =
      SplayTreeMap<String, Map<String, dynamic>>((String a, String b) {
    return -a.compareTo(b);
  });

  ScrollController scrollcontroller;
  bool showup = false;
  DateTime selecteddate;
  SplayTreeSet<Order> selectedorder;
  bool isdark;
  List<String> deliveryman = [
    "ahmed reda",
    "yousif elanany",
    "eslam reda",
    "elshazly"
  ];

  int comparetwoorder(Order a, Order b) {
    return -a.orderdate.compareTo(b.orderdate);
  }

  void RemoveOrder(String key, Order order) {
    setState(() {
      (orders[key]['list'] as SplayTreeSet<Order>).remove(order);
      if (orders[key]['list'].isEmpty) {
        orders.remove(key);
      }
    });
  }

  void addorder(String key, Order order) {
    Navigator.of(context).pop();
    setState(() {
      if (orders.containsKey(key)) {
        orders[key]["list"].add(order);
      } else {
        orders[key] = Map<String, dynamic>();
        orders[key]["date"] =
            DateFormat("EEEE,dd/MM/yyyy").format(order.orderdate);
        orders[key]["list"] = SplayTreeSet<Order>(comparetwoorder);
        orders[key]["list"].add(order);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isdark = false;
    scrollcontroller = ScrollController();
    final OrdersList = List.generate(12, (index) {
      return Order(
        deliveryman: deliveryman[Random().nextInt(3)],
        price: Random().nextDouble() * 500,
        orderdate: DateTime.now().subtract(
          Duration(
            days: Random().nextInt(12),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        ),
      );
    });
    OrdersList.forEach((element) {
      final key = DateFormat('yyyyMMdd').format(element.orderdate);
      if (!orders.containsKey(key)) {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE,dd/MM/yyyy').format(element.orderdate);
        orders[key]['list'] = SplayTreeSet<Order>(comparetwoorder);
      }
      orders[key]['list'].add(element);
    });
    selecteddate = DateTime.now();
    String key = DateFormat("yyyyMMdd").format(selecteddate);
    if (orders.containsKey(key)) {
      selectedorder = orders[key]["list"];
    } else {
      selectedorder = null;
    }
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  void changedate(DateTime date) {
    setState(() {
      selecteddate = date;
      String key = DateFormat("yyyyMMdd").format(selecteddate);
      if (orders.containsKey(key)) {
        selectedorder = orders[key]["list"];
      } else {
        selectedorder = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Stack(
          children: [
            backgroundscreen(),
            SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Homescreentitle(),
                    Chartscreen(selecteddate, changedate, selectedorder),
                    Expanded(
                      child: NotificationListener<ScrollUpdateNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels > 40 &&
                              showup == false) {
                            setState(() {
                              showup = true;
                            });
                          } else if (notification.metrics.pixels <= 40 &&
                              showup == true) {
                            setState(() {
                              showup = false;
                            });
                          }
                          return true;
                        },
                        child: ListView.builder(
                          controller: scrollcontroller,
                          padding: EdgeInsets.only(
                            bottom: kFloatingActionButtonMargin + 56,
                          ),
                          physics: BouncingScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            List<String> keys = orders.keys.toList();
                            String key = keys[index];
                            String date = orders[key]['date'];
                            SplayTreeSet<Order> list = orders[key]['list'];
                            return StickyHeader(
                                header: stickyheader(date),
                                content: Column(
                                  children: list.map((element) {
                                    return Order_Item(element, RemoveOrder);
                                  }).toList(),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 2 * kFloatingActionButtonMargin),
          child: Row(
            mainAxisAlignment: (showup)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (showup)
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    scrollcontroller.jumpTo(0.0);
                  },
                  child: Icon(Icons.keyboard_arrow_up),
                ),
              Spacer(),
              Switch(
                value: isdark,
                onChanged: (value) {
                  setState(() {
                    isdark = value;
                  });
                  widget.toggle();
                },
              ),
              FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return AddBottomSheet(deliveryman, addorder);
                      });
                },
              )
            ],
          ),
        ));
  }
}
