import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../models/tasks.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List color = [
    Color(0xffFFDEDE),
    Color(0xffc6e4ff),
    Color(0xffB1F8C1),
    Color(0xffFFDEDE),
    Color(0xffFFDEDE),
    Color(0xffc6e4ff),
    Color(0xffB1F8C1),
    Color(0xffFFDEDE),
  ];

  List<Tasks> _tasks = List<Tasks>();

  Future<List<Tasks>> fetchTasks() async {
    var res = await http.get(
        'https://cdn.fonibo.com/challenges/tasks.json?fbclid=IwAR0EsJagLeJ36w8FPlygLCfChmkxPbqsGwjLrcFuQbUVJnYK3pYP80oCF1k');

    var tasks = List<Tasks>();

    if (res.statusCode == 200) {
      var tasksJson = json.decode(res.body);
      for (var taskJson in tasksJson) {
        tasks.add(Tasks.fromJson(taskJson));
      }
    }
    return tasks;
  }

  @override
  void initState() {
    fetchTasks().then((value) {
      setState(() {
        _tasks.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Color(0xFF0176E1),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'task.',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            color: Color(0xFF0176E1),
          ),
        ),
      ),
      body: FutureBuilder(
        future: fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                    child: Text(
                      'Tasks',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Container(
                                height: 66.0,
                                width: 9.24,
                                decoration: BoxDecoration(
                                    color: color[index],
                                    borderRadius: BorderRadius.circular(6.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.16,
                                    bottom: 8.0,
                                    right: 14.0,
                                    top: 6.16),
                                child: Container(
                                  height: 66.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Color(0xffF8F8F8)),
                                  child: ListTile(
                                    title: Text(
                                      _tasks[index].title,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      DateFormat('MMM dd, yyyy')
                                          .format(_tasks[index].createdAt),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Icon(
                                      Icons.radio_button_off,
                                      color: Color(0xff0176E1),
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Go to add Task page');
        },
        child: Icon(
          Icons.add,
          color: Color(0xFF0176E1),
          size: 38.0,
        ),
        backgroundColor: Colors.white,
        elevation: 0.1,
      ),
    );
  }
}
