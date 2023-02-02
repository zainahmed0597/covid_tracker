import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
            child: Card(child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                ReusableRow(title: 'Cases',value: widget.totalCases.toString(),),
                ReusableRow(title: 'Deaths',value: widget.totalDeaths.toString(),),
                ReusableRow(title: 'Recovered',value: widget.todayRecovered.toString(),),
                ReusableRow(title: 'Critical',value: widget.critical.toString(),),
                ReusableRow(title: 'Total Recovered',value: widget.todayRecovered.toString(),),
                ReusableRow(title: 'Test',value: widget.test.toString(),),
                ReusableRow(title: 'Active',value: widget.active.toString(),),
              ],
            ),),
          ),
            CircleAvatar(radius: 50,backgroundImage: NetworkImage(widget.image),),
        ],)
      ],),
    );
  }
}
