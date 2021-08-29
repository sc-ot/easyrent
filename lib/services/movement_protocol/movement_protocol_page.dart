import 'dart:ffi';

import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movement_protocol_provider.dart';

class MovementProtocolPage extends StatelessWidget {
  const MovementProtocolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    InspectionReport inspectionReport = args as InspectionReport;
    return ChangeNotifierProvider<MovementProtocolProvider>(
      create: (context) => MovementProtocolProvider(inspectionReport),
      builder: (context, child) {
        MovementProtocolProvider movementProtocolProvider =
            Provider.of<MovementProtocolProvider>(context, listen: true);

        ScrollController scrollController = ScrollController();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              movementProtocolProvider.inspectionReport.vehicle!.licensePlate,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              scrollController.animateTo(200,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
          ),
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverAppBar(
                actions: [],
                leading: Container(),
                elevation: 0,
                flexibleSpace: Container(
                  height:300,
                  color: Colors.red,
                ),
                pinned: true,
                collapsedHeight: 300,
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.blue,
                          child: Text("OK"),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.blue,
                          child: Text("Nicht OK"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                  ListTile(
                    title: Text("HALLO"),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
