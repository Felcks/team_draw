import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:team_randomizer/main.dart';
import 'package:team_randomizer/modules/match/domain/models/game_date.dart';
import 'package:team_randomizer/modules/group/domain/repositories/group_repository.dart';
import 'package:team_randomizer/modules/group/presentation/group_creation/define_hour_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils.dart';
import '../../domain/models/group.dart';

class GroupCreation extends StatefulWidget {
  const GroupCreation({Key? key}) : super(key: key);

  @override
  State<GroupCreation> createState() => _GroupCreationState();
}

class _GroupCreationState extends State<GroupCreation> {
  final TextEditingController _titleTextFieldController = TextEditingController();
  final TextEditingController _locationTextFieldController = TextEditingController();

  final GlobalKey<FormState> _groupCreationFormKey = GlobalKey();

  DateTime _weekDay = DateTime(2018);
  Time _startTime = Time(hour: 18, minute: 00, second: 00);
  Time _endTime = Time(hour: 19, minute: 00, second: 00);

  final GroupRepository _groupRepository = GroupRepositoryImpl();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      "https://lh5.googleusercontent.com/p/AF1QipNczAUhbyQf2koTig0m41v7eShuv8MffbD6YCB8=w650-h486-k-no",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                color: Colors.white.withOpacity(0.1),
                child: Form(
                  key: _groupCreationFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleTextFieldController,
                          validator: (value) {
                            if ((value?.length ?? 0) < 3) {
                              return "Grupo deve possuir um nome de pelo menos 3 caracteres";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text("Nome do grupo"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _locationTextFieldController,
                          validator: (value) {
                            if ((value?.length ?? 0) < 3) {
                              return "O local do grupo deve ter pelo menos 3 caracteres";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text("Local"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  onTap: () {
                    _showWeekDaysModal();
                  },
                  child: Card(
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Dia da Semana"),
                            Row(
                              children: [
                                Text(
                                  DateFormat("EEEE").format(_weekDay),
                                  style: TextStyle(color: Colors.black.withOpacity(1)),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DefineHourWidget(
                    time: _startTime,
                    label: "Início",
                    onChange: (time) {
                      setState(() {
                        _startTime = time;
                      });
                    },
                  ),
                  DefineHourWidget(
                    time: _endTime,
                    label: "Fim",
                    onChange: (time) {
                      setState(() {
                        _endTime = time;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 56,
          child: TextButton(
            child: const Text(
              "Cancelar",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(
          height: 56,
          child: Center(
            child: Text(
              "Novo Grupo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 56,
          child: TextButton(
            child: const Text(
              "OK",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onPressed: () {
              bool? isValid = _groupCreationFormKey.currentState?.validate();
              if (isValid == true) {
                Group group = Group(
                  id: const Uuid().v4(),
                  userId: loggedUser?.id ?? "",
                  title: _titleTextFieldController.text,
                  startTime: TimeOfDay(hour: _startTime.hour, minute: _startTime.minute),
                  endTime: TimeOfDay(hour: _endTime.hour, minute: _endTime.minute),
                  local: _locationTextFieldController.text,
                  image: "",
                  date: GameDate(weekDay: _weekDay.weekday),
                );
                _groupRepository.createGroup(group);
                Navigator.pop(context);
              }
            },
          ),
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
        ),
      ),
    );
  }

  void _showWeekDaysModal() {
    DateTime monday = DateTime(2018);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: (isTablet(context)) ? true : false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setModalState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  width: 32,
                  child: Divider(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Dia da semana",
                  style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      shape: BoxShape.rectangle,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: List.generate(
                          DateTime.daysPerWeek,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _weekDay = DateTime(2018).add(Duration(days: index));
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat("EEEE").format(monday.add(Duration(days: index))),
                                            style: TextStyle(color: Colors.black.withOpacity(1)),
                                          ),
                                          (_weekDay.weekday - 1 == index) ? const Icon(Icons.done) : Container(),
                                        ],
                                      ),
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
            );
          },
        );
      },
    );
  }
}
