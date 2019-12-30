import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double percentage;
  final bool isPortrait;

  ChartBar(this.day, this.amount, this.percentage, this.isPortrait);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return isPortrait
          ? Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.5),
                  height: constraints.maxHeight * 0.15,
                  child:
                      FittedBox(child: Text('\$${amount.toStringAsFixed(2)}')),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.6,
                  width: 10.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.15,
                  child: FittedBox(child: Text(day)),
                ),
              ],
            )
          : Row(
              children: <Widget>[
                Container(
                  width: constraints.maxWidth * 0.1,
                  height: 25.0,
                  child: FittedBox(child: Text(day)),
                ),
                SizedBox(width: constraints.maxWidth * 0.05),
                Container(
                  width: constraints.maxWidth * 0.6,
                  height: 10.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: constraints.maxWidth * 0.05),
                Container(
                  width: constraints.maxWidth * 0.2,
                  child: FittedBox(
                    child: Text('\$${amount.toStringAsFixed(2)}'),
                  ),
                ),
              ],
            );
    });
  }
}
