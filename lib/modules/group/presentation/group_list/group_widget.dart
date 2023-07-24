import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../domain/models/group.dart';

class GroupWidget extends StatelessWidget {
  final Group group;
  final void Function(Group) onClick;

  const GroupWidget({Key? key, required this.group, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call(group);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(32.0),
                shape: BoxShape.rectangle,
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Image.network(
                group.image,
                fit: BoxFit.fitHeight,
                height: 200,
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                shape: BoxShape.rectangle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    group.title,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
