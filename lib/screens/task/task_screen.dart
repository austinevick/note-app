import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    floating: true,
                    centerTitle: true,
                    actions: [
                      IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 29,
                          ),
                          onPressed: () {}),
                    ],
                    title: Text(
                      'Task',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ],
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      5,
                      (i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          height: 150,
                          width: 150,
                          child: Column(
                            children: [
                              Text('40 tasks'),
                              Text('Business'),
                              LinearProgressIndicator(value: 0.5)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (context, index) => Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          RoundCheckBox(onTap: (value) {}, size: 25),
                          Text('Daily meeting with Tim')
                        ],
                      ),
                    )),
                  ),
                )
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff0f044c),
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (ctx) => NewNoteScreen()));
            },
            child: Icon(Icons.add, size: 29)),
      ),
    );
  }
}
