import 'package:flutter/material.dart';

import 'responsive.dart';

class CustomMonthPicker extends StatelessWidget {
  final DateTime datetime;
  final Function sub;
  final Function add;

  const CustomMonthPicker(
      {Key key,
      @required this.datetime,
      @required this.sub,
      @required this.add})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return SliverPadding(
      padding: !isDesktop
          ? EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)
          : EdgeInsets.all(0.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
            // color: Colors.blue.shade50,
            color: Colors.white,
            borderRadius: isDesktop ? BorderRadius.circular(10.0) : null,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              InkWell(
                // margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black45,
                  ),
                ),
                onTap: sub,
              ),
              Expanded(
                child: Text(
                  "Tháng ${datetime.month.toString().padLeft(2, '0')}/${datetime.year.toString()}",
                  // "Tháng ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Colors.black45,
                    fontSize: 15.0,
                  ),
                ),
              ),
              datetime.month < DateTime.now().month
                  ? InkWell(
                      // margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black45,
                        ),
                      ),
                      onTap: add,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black12,
                      ),
                    ),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
