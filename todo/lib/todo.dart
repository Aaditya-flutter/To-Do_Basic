import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State createState() => _TodoState();
}

class TaskData {
  String title;
  String description;
  String date;

  TaskData(
      {required this.title, required this.description, required this.date});
}

class User {
  String username;
  String password;

  User({required this.username, required this.password});
}

class _TodoState extends State {
  List<TaskData> taskCard = [];
  List<Color> cardcolor = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];
  List<User> userInfo = [
    User(username: "Aaditya", password: "login"),
    User(username: "Mohit", password: "open"),
  ];

  bool loginSuccessful = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void selectDate() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );
    String formatedDate = DateFormat.yMMMd().format(pickDate!);
    setState(() {
      dateController.text = formatedDate;
    });
  }

  submit(bool isEditing, [TaskData? taskDataObj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (isEditing) {
        taskDataObj!.title = titleController.text.trim();
        taskDataObj.description = descriptionController.text.trim();
        taskDataObj.date = dateController.text.trim();
      } else {
        taskCard.add(
          TaskData(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            date: dateController.text.trim(),
          ),
        );
      }
    }
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    setState(() {});
    Navigator.of(context).pop();
  }

  editCard(TaskData taskDataObj) {
    titleController.text = taskDataObj.title;
    descriptionController.text = taskDataObj.description;
    dateController.text = taskDataObj.date;

    displayBottomSheet(true, taskDataObj);
  }

  @override
  Widget build(BuildContext context) {
    if (!loginSuccessful) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 370,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Log in",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      "Log in to continue",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Username",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: usernameController,
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        constraints: BoxConstraints(
                          maxHeight: 50,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                      ),
                      validator: (value) {
                        print("In username validator");
                        print(usernameController.text);
                        if (value == null || value.isEmpty) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: passwordController,
                      textAlignVertical: TextAlignVertical.top,
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        constraints: BoxConstraints(
                          maxHeight: 50,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        print("In password validator");
                        print(passwordController.text);
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        _formKey.currentState!.validate();
                        if (userInfo.contains(User(
                            username: usernameController.text,
                            password: passwordController.text))) {
                          setState(() {
                            loginSuccessful = _formKey.currentState!.validate();
                          });
                        }
                        if (loginSuccessful) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Welcome ${usernameController.text}"),
                            ),
                          );
                          // setState(() {});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter valid username or password"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 139, 148, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log in",
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
          title: Text(
            "To-do list",
            style: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 400,
                  height: 760,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: taskCard.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 330,
                        height: 127,
                        margin: const EdgeInsets.only(
                          top: 25,
                          left: 15,
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          color: cardcolor[index % cardcolor.length],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                    top: 23,
                                    left: 17.5,
                                    right: 17.5,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Color.fromRGBO(0, 0, 0, 0.07),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    "assets/images/onerror.png",
                                    width: 26.79,
                                    height: 22.07,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 265,
                                      height: 15,
                                      margin: const EdgeInsets.only(right: 15),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          taskCard[index].title,
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 265,
                                      height: 44,
                                      margin: const EdgeInsets.only(right: 15),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Text(
                                          taskCard[index].description,
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                              color:
                                                  Color.fromRGBO(84, 84, 84, 1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  taskCard[index].date,
                                  style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(132, 132, 132, 1),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    color: Color.fromRGBO(0, 139, 148, 1),
                                    Icons.mode_edit_outline_outlined,
                                  ),
                                  onPressed: () {
                                    editCard(taskCard[index]);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    color: Color.fromRGBO(0, 139, 148, 1),
                                    Icons.delete_outline_sharp,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      taskCard.remove(taskCard[index]);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            displayBottomSheet(false);
          },
          shape: const CircleBorder(eccentricity: 0),
          backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
          child: const Icon(
            Icons.add_sharp,
            size: 50,
            color: Colors.white,
            shadows: [
              BoxShadow(
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ],
          ),
        ),
      );
    }
  }

  void displayBottomSheet(bool isEditing, [TaskData? taskDataObj]) {
    if (!isEditing) {
      titleController.clear();
      descriptionController.clear();
      dateController.clear();
    }
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 13,
              ),
              Text(
                "Create TaskData",
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextField(
                    controller: titleController,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      constraints: BoxConstraints(
                        maxHeight: 50,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextField(
                    controller: descriptionController,
                    minLines: 1,
                    maxLines: 4,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    decoration: const InputDecoration(
                      constraints: BoxConstraints(
                        minHeight: 60,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Date",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextField(
                    controller: dateController,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    onTap: selectDate,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 50,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: selectDate,
                        child: const Icon(
                          Icons.calendar_month_outlined,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 330,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    submit(isEditing, taskDataObj);
                  },
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(0, 139, 148, 1),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }
}
