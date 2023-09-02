import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../group/domain/models/group.dart';
import '../../domain/player.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey();

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _header(),
            const SizedBox(
              height: 16,
            ),
            /*_photoWidget(),
            /SizedBox(
              height: 32,
            ),*/
            Expanded(
              flex: 9,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _nameTextField(),
                        const SizedBox(
                          height: 16,
                        ),
                        _overallWidget()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
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
          child: const Text("Cancelar"),
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        TextButton(
          child: const Text("Ok"),
          onPressed: () {

            if(_formKey.currentState?.validate() == false) {
              return;
            }

            if (widget.player == null) {
              Player player = Player(
                id: const Uuid().v4(),
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
    return TextFormField(
      controller: _nameTextFieldController,
      validator: (value) {
        if((value?.length ?? 0) > 20) {
          return "Nome deve possuir menos de 20 caracters";
        }

        return null;
      },
      decoration: InputDecoration(
        label: const Text("Nome"),
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            const Text(
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
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Card(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Image.network(
              "https://i2-prod.chroniclelive.co.uk/incoming/article21727252.ece/ALTERNATES/s1227b/0_FernandezJPG.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
