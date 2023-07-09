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
      child: Container(
        child: Stack(
          children: [
            Image.network(
              group.image,
              fit: BoxFit.fitHeight,
              height: 200,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(4.0),
                  shape: BoxShape.rectangle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      group.title,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
