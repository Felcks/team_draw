import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_randomizer/modules/game/presentation/group_creation/define_hour_widget.dart';

import '../../../core/data/database_utils.dart';

class GroupCreation extends StatefulWidget {
  const GroupCreation({Key? key}) : super(key: key);

  @override
  State<GroupCreation> createState() => _GroupCreationState();
}

class _GroupCreationState extends State<GroupCreation> {
  TextEditingController _titleTextFieldController = TextEditingController();
  TextEditingController _locationTextFieldController = TextEditingController();

  DateTime _weekDay = DateTime(2018);
  Time _startTime = Time(hour: 18, minute: 00, second: 00);
  Time _endTime = Time(hour: 19, minute: 00, second: 00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: new BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              color: Colors.white.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _textField(_titleTextFieldController, "Nome"),
                    SizedBox(
                      height: 16,
                    ),
                    _textField(_locationTextFieldController, "Local"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () {
                  _showWeekDaysModal();
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dia da Semana"),
                          Row(
                            children: [
                              Text(
                                DateFormat("EEEE").format(_weekDay),
                                style: TextStyle(color: Colors.black.withOpacity(1)),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefineHourWidget(
                  time: _startTime,
                  label: "Start",
                ),
                DefineHourWidget(
                  time: _endTime,
                  label: "End",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
                "Novo Grupo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            DatabaseReference ref = getDatabase().ref();
            ref.child("group").push().set({
              "title": _titleTextFieldController.text,
              "local": _locationTextFieldController.text,
              "weekday": _weekDay.weekday,
              "image": "",
              "startTime": TimeOfDay(hour: _startTime.hour, minute: _startTime.minute).format(context),
              "endTime": TimeOfDay(hour: _endTime.hour, minute: _endTime.minute).format(context)
            });
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget _textField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          )),
    );
  }

  void _showWeekDaysModal() {
    DateTime monday = DateTime(2018);

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 32,
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Dia da semana",
                    style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.all(
                          Radius.circular(8),
                        ),
                        shape: BoxShape.rectangle,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: List.generate(
                            DateTime.daysPerWeek,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _weekDay = DateTime(2018).add(Duration(days: index));
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat("EEEE").format(monday.add(Duration(days: index))),
                                            style: TextStyle(color: Colors.black.withOpacity(1)),
                                          ),
                                          (_weekDay.weekday - 1 == index) ? Icon(Icons.done) : Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
