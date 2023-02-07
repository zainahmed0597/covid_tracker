import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    print('Data 1 clear');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: statesServices.fecthWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if(!snapshot.hasData){
                      print('${snapshot} Data 2 clear');
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ));
                    } else {
                      print('${snapshot} Data 3 clear');
                      return Column(
                        children: [
                          PieChart(
                          dataMap:  {
                            "Total": double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths.toString()),
                          },
                            chartValuesOptions:  const ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Active', value: snapshot.data!.active.toString(),),
                                  ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString(),),
                                  ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString(),),
                                  ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString(),),
                                  ReusableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString(),),
                                  ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString(),),
                                  ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString(),),
                                  ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString(),),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                            },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff1aa260),
                              ),
                              child: const Center(
                                child: Text('Track Country'),
                              ),
                            ),
                          ),],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
