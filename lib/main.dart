import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: QuizApp()),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State createState() => _QuizApp();
}

class _QuizApp extends State {
  bool doEdit = false;
  void submit(bool doEdit, [TodoModal? obj]) {
    if (_titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty) {
      if (!doEdit) {
        setState(() {
          containerCard.add(
            TodoModal(
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                date: _dateController.text.trim()),
          );
        });
      } else {
        setState(() {
          obj!.title = _titleController.text.trim();
          obj.description = _descriptionController.text.trim();
          obj.date = _dateController.text.trim();
        });
      }
    }
    clearController();
  }

  void deleteCard(TodoModal obj) {
    setState(() {
      containerCard.remove(obj);
    });
  }

  void editCard(TodoModal obj) {
    _titleController.text = obj.title;
    _descriptionController.text = obj.description;
    _dateController.text = obj.date;

    bottomSheet(true, obj);
  }

  void clearController() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void bottomSheet(bool doEdit, [TodoModal? obj]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Task',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Description',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Date',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.date_range_sharp),
                        hintText: 'Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025),
                        );
                        String formatDate =
                            DateFormat.yMMMd().format(pickDate!);
                        setState(() {
                          _dateController.text = formatDate;
                        });
                      }),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (!doEdit) {
                    submit(doEdit);
                  } else {
                    submit(doEdit, obj);
                  }
                  //submit(doEdit);

                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromRGBO(2, 167, 177, 1),
                  ),
                  // foregroundColor: MaterialStatePropertyAll(
                  //   Color.fromRGBO(255, 255, 255, 0),
                  // ),
                ),
                child: Text(
                  'Submit',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<TodoModal> containerCard = [
    TodoModal(
        title: 'Instagram API',
        description: 'Backend Bind',
        date: '13 March 2024'),
  ];
  List containerColor = const [
    Color.fromRGBO(250, 232, 232, 1),
    Color.fromRGBO(232, 237, 250, 1),
    Color.fromRGBO(252, 250, 227, 1),
    Color.fromRGBO(250, 232, 250, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
          title: Text(
            'To-do list',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              fontSize: 26,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: ListView.builder(
            itemCount: containerCard.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // height: 112,
                // width: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: containerColor[index % containerColor.length],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    //const SizedBox(height: 20),
                    Row(
                      children: [
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Image.asset(
                              'assets/images/Screenshot 2024-03-13 114937.png'),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                containerCard[index].title,
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                containerCard[index].description,
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          containerCard[index].date,
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            editCard(containerCard[index]);
                          },
                          child: const Icon(Icons.edit,
                              color: Color.fromRGBO(0, 139, 148, 1)),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            deleteCard(containerCard[index]);
                          },
                          child: const Icon(Icons.delete_outlined,
                              color: Color.fromRGBO(0, 139, 148, 1)),
                        ),
                        //const SizedBox(width: 15),
                        // GestureDetector(
                        //     onTap: () {
                        //       setState(() {});
                        //     },
                        //     child: const Icon(Icons.check_circle_outline))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bottomSheet(doEdit);
          },
          backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TodoModal {
  String title = '';
  String description = '';
  String date = '';
  TodoModal(
      {required this.title, required this.description, required this.date});
}
