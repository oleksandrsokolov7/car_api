import 'package:car_api/constants.dart';
import 'package:flutter/material.dart';

class YearFilterForm extends StatefulWidget {
  YearFilterForm({Key? key, required this.year}) : super(key: key);

  String year;

  @override
  _YearFilterFormState createState() => _YearFilterFormState();
}

class _YearFilterFormState extends State<YearFilterForm> {
  @override
  Widget build(BuildContext context) {
//------------------------------------------------
    List<String> listYear = [
      '2015',
      '2016',
      '2017',
      '2018',
      '2019',
      '2020',
    ];

//------------------------------------------------
    int r0 = 0;
    String groupValue = widget.year;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Year',
          style: txt30,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 5,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return RadioMenuButton(
                        child: Text(listYear[index]),
                        value: listYear[index],
                        groupValue: widget.year,
                        onChanged: (val) {
                          setState(() {
                            print(val);
                            widget.year = val!;
                          });
                        });
                  },
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                  itemCount: listYear.length),
            ),
            Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            print(widget.year);
                            Navigator.pop(context, widget.year);
                          },
                          child: Text('OK')),
                    ),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            print('Cancel');
                            Navigator.pop(context, null);
                          },
                          child: Text('Cancel')),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
