import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../game/domain/models/group.dart';
import '../../../game/domain/models/player.dart';
import '../../../player/domain/player_repository.dart';

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

  PlayerRepositoryImpl playerRepository = PlayerRepositoryImpl();

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
            _photoWidget(),
            SizedBox(
              height: 32,
            ),
            Container(
              color: Colors.white.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _nameTextField(),
                    SizedBox(
                      height: 16,
                    ),
                    _overallWidget()
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
                (widget.player == null) ? "Adicionar Jogador" : "Editar Jogador",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            if (widget.player == null) {
              Player player = Player(
                id: Uuid().v4(),
                groupId: widget.group.id,
                name: _nameTextFieldController.text,
                overall: _overall.toInt(),
              );

              playerRepository.createPlayer(player);
            } else {
              Player player = Player(
                id: widget.player!.id,
                groupId: widget.group.id,
                name: _nameTextFieldController.text,
                overall: _overall.toInt(),
              );

              playerRepository.editPlayer(player);
            }

            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget _nameTextField() {
    return TextField(
      controller: _nameTextFieldController,
      decoration: InputDecoration(
        label: Text("Nome"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _overallWidget() {
    return Container(
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
    );
  }

  Widget _photoWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.5,
      decoration: new BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(64),
      ),
    );
  }
}
