import 'package:flutter/material.dart';

class DueTask {
  bool isExpanded;
  String header;
  BodyModel bodyModel;

  DueTask({this.isExpanded: false, this.header, this.bodyModel});
}

class BodyModel {
  int price;
  int quantity;

  BodyModel({this.price, this.quantity});
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 200,
        child: ListView.builder(
          itemCount: prepareData.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionPanelList(
              animationDuration: Duration(seconds: 1),
              children: [
                ExpansionPanel(
                  body: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'PRICE: ${prepareData[index].bodyModel.price}',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'QUANTITY: ${prepareData[index].bodyModel.quantity}',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        prepareData[index].header,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: prepareData[index].isExpanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  prepareData[index].isExpanded =
                      !prepareData[index].isExpanded;
                });
              },
            );
          },
        ),
    );
  }

  List<DueTask> prepareData = <DueTask>[
    DueTask(header: 'Milk', bodyModel: BodyModel(price: 20, quantity: 10)),
    DueTask(header: 'Coconut', bodyModel: BodyModel(price: 35, quantity: 5)),
    DueTask(header: 'Watch', bodyModel: BodyModel(price: 800, quantity: 15)),
    DueTask(header: 'Cup', bodyModel: BodyModel(price: 80, quantity: 150))
  ];
}
