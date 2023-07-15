import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class DefineHourWidget extends StatefulWidget {
  Time time;
  final String label;
  DefineHourWidget({Key? key, required this.time, required this.label}) : super(key: key);

  @override
  State<DefineHourWidget> createState() => _DefineHourWidgetState();
}

class _DefineHourWidgetState extends State<DefineHourWidget> {

  bool iosStyle = true;
  bool is24HrFormat = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          showPicker(
            context: context,
            value: widget.time,
            iosStylePicker: iosStyle,
            is24HrFormat: is24HrFormat,
            onChange: (time) {
              setState(() {
                widget.time = time;
              });
            },
          ),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: 150,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
              color: Colors.grey.withOpacity(0.1)
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Text(widget.label),
                Text(widget.time.format(context), style: TextStyle(fontSize: 36),),
                SizedBox(),
                SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
