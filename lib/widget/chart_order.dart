import 'dart:collection';

import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widget/chart_bar.dart';
import 'package:delivery_manager/widget/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chartscreen extends StatefulWidget {
  final DateTime selecteddate;
  final Function changedate;
  final SplayTreeSet<Order> selectedorder;

  Chartscreen(this.selecteddate, this.changedate, this.selectedorder);

  @override
  State<Chartscreen> createState() => _ChartscreenState();
}

class _ChartscreenState extends State<Chartscreen> {
  Map<String, int> count;
  double calculateheight(int NumberOfOrder, BoxConstraints constraints) {
    return NumberOfOrder * constraints.maxHeight / 20;
  }

  void filterorder() {
    count = Map<String, int>();
    if (widget.selectedorder != null) {
      widget.selectedorder.forEach((element) {
        if (count.containsKey(element.deliveryman)) {
          count[element.deliveryman]++;
        } else {
          count[element.deliveryman] = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    filterorder();
    return Card(
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ).add(
        EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  DateTime date =
                      DateTime.now().subtract(Duration(days: index));
                  String text = DateFormat("dd/MM").format(date);
                  bool isselected =
                      text == DateFormat("dd/MM").format(widget.selecteddate);
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 6 ? 0 : 2, right: index == 0 ? 0 : 2),
                    child: TextButton(
                      onPressed: () {
                        widget.changedate(date);
                      },
                      child: Text(text),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: count.length != 0
                  ? Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              const Text("#orders"),
                              Expanded(child: Container()),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    HeroItem("yousif elanany", Colors.blue),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    HeroItem("ahmed reda", Colors.red),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    HeroItem("eslam reda ", Colors.yellow),
                                    HeroItem("elshazly ", Colors.black),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                children: [
                                  Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth * 0.1,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text("20"),
                                          Text("10"),
                                          Text("0"),
                                        ]),
                                  ),
                                  Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth * 0.9,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (count.containsKey("yousif elanany"))
                                          chartbar(
                                            color: Colors.blue,
                                            height: calculateheight(
                                                count["yousif elanany"],
                                                constraints),
                                            numberoforder:
                                                count["yousif elanany"],
                                            name: "yousif elanany",
                                          ),
                                        if (count.containsKey("ahmed reda"))
                                          chartbar(
                                            color: Colors.red,
                                            height: calculateheight(
                                                count["ahmed reda"],
                                                constraints),
                                            numberoforder: count["ahmed reda"],
                                            name: "ahmed reda",
                                          ),
                                        if (count.containsKey("eslam reda"))
                                          chartbar(
                                            color: Colors.yellow,
                                            height: calculateheight(
                                                count["eslam reda"],
                                                constraints),
                                            name: "eslam reda",
                                            numberoforder: count["eslam reda"],
                                          ),
                                        if (count.containsKey("elshazly"))
                                          chartbar(
                                            color: Colors.black,
                                            height: calculateheight(
                                                count["elshazly"], constraints),
                                            name: "elshazly",
                                            numberoforder: count["elshazly"],
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                      "no orders",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
