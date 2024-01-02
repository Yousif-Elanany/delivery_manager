import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widget/drop_down_desciption_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class AddBottomSheet extends StatefulWidget {
  final List<String> deliveryman;
  final Function addorder;
  AddBottomSheet(this.deliveryman, this.addorder);
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  String SelectedDeliveryman;
  DateTime selecteddate;
  TextEditingController pricecontroller;
  @override
  void initState() {
    super.initState();
    SelectedDeliveryman = widget.deliveryman[0];
    selecteddate = DateTime.now();
    pricecontroller = TextEditingController();
  }

  void dispose() {
    pricecontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print(selecteddate);
    return Container(
      color: Theme.of(context).accentColor,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Text(
                "lets add order",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dropdowndecriptiontitle("who will deliver?"),
                  Card(
                    color: Colors.blue[100],
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          value: SelectedDeliveryman,
                          items: widget.deliveryman.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              SelectedDeliveryman = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  dropdowndecriptiontitle("when wil be delivered ?"),
                  Row(
                    children: [
                      TextButton(
                        child: Text(DateFormat('EEEE , dd/MM/yyyy')
                            .format(selecteddate)),
                        onPressed: () async {
                          DateTime PickedDate = await showDatePicker(
                            context: context,
                            initialDate: selecteddate,
                            firstDate:
                                DateTime.now().subtract(Duration(days: 7)),
                            lastDate: DateTime.now().add(Duration(days: 90)),
                          );
                          if (PickedDate != null) {
                            setState(() {
                              selecteddate = DateTime(
                                PickedDate.year,
                                PickedDate.month,
                                PickedDate.day,
                                selecteddate.hour,
                                selecteddate.minute,
                              );
                            });
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("at"),
                      ),
                      TextButton(
                        child: Text(DateFormat("hh:mm a").format(selecteddate)),
                        onPressed: () async {
                          TimeOfDay PickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (PickedTime != null) {
                            setState(() {
                              selecteddate = DateTime(
                                selecteddate.year,
                                selecteddate.month,
                                selecteddate.day,
                                PickedTime.hour,
                                PickedTime.minute,
                              );
                            });
                          }
                        },
                      )
                    ],
                  ),
                  dropdowndecriptiontitle("what is the price"),
                  Card(
                    elevation: 5,
                    color: Colors.blue[100],
                    child: TextField(
                      controller: pricecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "please enter the price",
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          "Add Order",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          try {
                            double price = double.parse(pricecontroller.text);
                            if (price < 0) {
                              throw "invalid price";
                            }
                            String key =
                                DateFormat("yyyyMMdd").format(selecteddate);
                            Order order = Order(
                              deliveryman: SelectedDeliveryman,
                              orderdate: selecteddate,
                              price: price,
                            );
                            widget.addorder(key, order);
                          } catch (error) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("invalid order data"),
                                    content: Text("please enter valid price"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
