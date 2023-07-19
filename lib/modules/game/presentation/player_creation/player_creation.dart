import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_randomizer/modules/game/presentation/group_creation/define_hour_widget.dart';

import '../../../core/data/database_utils.dart';
import '../../domain/models/group.dart';
import '../../domain/models/player.dart';

class PlayerCreationPage extends StatefulWidget {
  final Group group;
  Player? player = null;

  PlayerCreationPage({Key? key, required this.group, this.player}) : super(key: key);

  @override
  State<PlayerCreationPage> createState() => _PlayerCreationPageState();
}

class _PlayerCreationPageState extends State<PlayerCreationPage> {
  TextEditingController _nameTextFieldController = TextEditingController();
  double _overall = 50;

  @override
  void initState() {
    if (widget.player != null) {
      _overall = widget.player!.overall.toDouble();
      _nameTextFieldController.text = widget.player!.name;
    }

    super.initState();
  }

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
                    _textField(_nameTextFieldController, "Nome"),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(8.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(1),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            Text(
                              "Overall",
                              style: TextStyle(fontSize: 20),
                            ),
                            Slider(
                              value: _overall,
                              min: 0,
                              max: 100,
                              onChanged: (double value) {
                                setState(() {
                                  _overall = value;
                                });
                              },
                            ),
                            Text(_overall.toInt().toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
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
                "Adicionar Player",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            DatabaseReference ref = getDatabase().ref();
            if (widget.player == null) {
              ref.child("player").push().set({
                "name": _nameTextFieldController.text,
                "overall": _overall.toInt(),
                "groupId": widget.group.id,
              });
            } else {
              ref.child("player/${widget.player!.id}").update({
                "name": _nameTextFieldController.text,
                "overall": _overall.toInt(),
              });
            }
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
}
