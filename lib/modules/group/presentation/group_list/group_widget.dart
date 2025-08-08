import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/utils.dart';
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
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  group.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    group.title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            (isTablet(context)) ? _tabletLayout(context) : _tabletLayout(context)
          ],
        ),
      ),
    );
  }

  Widget _tabletLayout(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                const Text(
                  "Próxima data: ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  group.date.getNextDateFormatted(),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                const Text(
                  "Horário: ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  group.startTime.format(context) + " - " + group.endTime.format(context),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                const Text(
                  "Local: ",
                  style: TextStyle(color: Colors.black),
                ),
                ClipRect(
                  child: Text(
                    group.local,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
