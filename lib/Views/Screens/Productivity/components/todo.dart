import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/Models/todo_model.dart';
import 'package:mcircle_project_ui/Providers/folder_provider.dart';
import 'package:mcircle_project_ui/Providers/todo_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_folders.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_todos.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/update_folder.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/update_todo.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Todo extends StatefulWidget {
  Todo({
    Key? key,
    required this.widget,
    required this.folder,
  }) : super(key: key);
  final Function widget;
  final FolderModel folder;
  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final seletedTodo = [];
  FolderModel? getFolder;
  String? title;
  int _ed = 0;
  int page = 1;
  int indexList = 0;
  late bool isChecked;
  TodoModel? todoModel;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    isChecked = false;
    getFolder = widget.folder;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false)
          .getTodoData(getFolder!.sId!, page);
    });
    setData();
  }

  setData() {
    setState(() {
      if (!mounted) {
        return;
      }
      title = widget.folder.name;
    });
  }

  callback(newTitle) {
    setState(() {
      if (!mounted) {
        return;
      }
      title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1095,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: (_ed == 1)
            ? CreateTodo(folder: getFolder!)
            : (_ed == 2)
                ? UpdateFolder(dataFolder: getFolder!, callback: callback)
                : (_ed == 3)
                    ? UpdateTodo(
                        dataFolderModel: getFolder!,
                        dataTodoModel: todoModel!,
                      )
                    : SizedBox(),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Color.fromARGB(255, 250, 249, 249),
        body: Column(
          children: [
            Container(
              width: 1095,
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(11)),
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back_ios,
                                    color: kPrimaryColor),
                                SizedBox(width: 3),
                                Text(
                                  "List",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (!mounted) {
                                return;
                              }
                              widget.widget(3);
                            });
                            // Navigator.of(context).pop();
                          }),
                      Text(
                        "${title}",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      PopupMenuButton<int>(
                        elevation: 0.0,
                        splashRadius: 1.0,
                        position: PopupMenuPosition.under,
                        icon: Icon(Icons.more_horiz_outlined,
                            color: kPrimaryColor),
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: kPrimaryColor),
                                SizedBox(width: 8),
                                Text("Update")
                              ],
                            ),
                            value: 0,
                          ),
                          PopupMenuItem<int>(
                            child: Row(children: [
                              Icon(Icons.delete, color: kPrimaryColor),
                              SizedBox(width: 8),
                              Text("Delete")
                            ]),
                            value: 1,
                          ),
                        ],
                        // onCanceled: () {
                        //   setState(() {
                        //     // _trailing = false;
                        //   });
                        // },
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              setState(() {
                                if (!mounted) {
                                  return;
                                }
                                _ed = 2;
                                _scaffoldKey.currentState?.openEndDrawer();
                              });
                              break;
                            case 1:
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Comfirmation",
                                desc:
                                    "Are you sure you want to delete this folder?",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Family Name"),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: Colors.red,
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Family Name"),
                                    ),
                                    onPressed: () async {
                                      String sId = getFolder!.sId!;
                                      var response = await deleteFolder(sId)
                                          .whenComplete(() => {
                                                setState(() {
                                                  if (!mounted) {
                                                    return;
                                                  }
                                                  widget.widget(3);
                                                  Navigator.pop(context);
                                                })
                                              });
                                      if (response == 200) {
                                        print("Done");
                                      }
                                    },
                                    color: Colors.green,
                                  )
                                ],
                              ).show();
                              break;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   width: 60,
                      //   height: 25,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8),
                      //       color: Colors.white),
                      // ),
                      Container(
                        height: 40,
                        width: 250,
                        // constraints: BoxConstraints(maxWidth: 250),
                        child: TextFormField(
                          onChanged: (value) async {
                            String search = value;
                            String? folderId = getFolder?.sId;
                            final response =
                                await searchTodo(search, folderId!);
                            if (response != null) {
                              Provider.of<TodoProvider>(context, listen: false)
                                  .getSearchTodo(search, folderId);
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(11.0),
                              ),
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11.0)),
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            hintText: "Search",
                            suffixIcon:
                                Icon(Icons.search, color: kPrimaryColor),
                            filled: true,
                          ),
                        ),
                        // color: Colors.pink,
                      ),
                      // SizedBox(width: 650),
                      ElevatedButton(
                        onPressed: () {
                          _ed = 1;
                          _scaffoldKey.currentState?.openEndDrawer();
                          setState(() {
                            if (!mounted) {
                              return;
                            }
                          });
                        },
                        child: Text("New Todo"),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
               Container(
                width: 1098,
                height: 570,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Task"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("list"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("DateTime"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("End-Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Location"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Priority"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Reminder"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Progress"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("File"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Note"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Updated"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Divider(color: kPrimaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Consumer<TodoProvider>(
                            builder: (__, notifier, child) {
                          if (notifier.state == NotifierState.loading) {
                            child = Center(
                              child: Container(
                                height: 430,
                                child: SpinKitRotatingCircle(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ),
                              ),
                            );
                          } else if (notifier.todoData != null && notifier.todoData!.data !=null &&
                              notifier.todoData!.data!.isNotEmpty &&
                              notifier.state == NotifierState.loaded) {
                            child = Container(
                              height: 430,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: notifier.todoData!.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TodoModel _todo =
                                      notifier.todoData!.data![index];
                                  return InkWell(
                                    // onTap: () {
                                    //   setState(() {
                                    //     widget.callback1!(
                                    //         notifier.tripData!.data![index]);
                                    //   });
                                    // },
                                    child: Container(
                                      // margin: EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kPrimaryColor),
                                                        value: _todo.mark,
                                                        shape: CircleBorder(),
                                                        onChanged: (bool?
                                                            value) async {
                                                          String folderId =
                                                              widget.folder.sId!;
                                                          String todoId =
                                                              _todo.sId!;
                                                          bool mark = value!;
                                                          var response =
                                                              await markAsDone(
                                                                  folderId,
                                                                  todoId,
                                                                  mark);
                                                          if (response !=
                                                              null) {
                                                            Provider.of<TodoProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .createUpdate(
                                                                    response);
                                                          }
                                                        },
                                                      ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              child: Text(
                                                (_todo.title!.length >= 15)
                                                    ? (_todo.title!
                                                            .substring(0, 15) +
                                                        "...")
                                                    : (_todo.title!),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              child: Text(getFolder!.name!),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text((_todo.dateTime !=
                                                          null &&
                                                      _todo.dateTime!
                                                          .isNotEmpty &&
                                                      _todo.dateTime!.length >
                                                          7)
                                                  ? (_todo.dateTime!
                                                      .substring(0, 7))
                                                  : "N/A"),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text(_todo.repeat!),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              child: Text(
                                                (_todo.endRepeat!.isNotEmpty &&
                                                        _todo.endRepeat !=
                                                            null &&
                                                        _todo.endRepeat!
                                                                .length >
                                                            7)
                                                    ? _todo.endRepeat!
                                                        .substring(0, 7)
                                                    : _todo.endRepeat!,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              child: Text(_todo.location!),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text(_todo.priority!),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: FlutterSwitch(
                                                activeColor: kPrimaryColor,
                                                padding: 0,
                                                width: 55.0,
                                                height: 25.0,
                                                valueFontSize: 12.0,
                                                // toggleSize: 18.0,
                                                value: _todo.reminder!,
                                                onToggle: (val) async {
                                                  // String tripId = _todo.sId!;
                                                  // bool reminder = val;
                                                  // var response =
                                                  //     await tripReminder(
                                                  //         tripId, reminder);
                                                  // if (response != null) {
                                                  //   Provider.of<TripProvider>(
                                                  //           context,
                                                  //           listen: false)
                                                  //       .createUpdate(response);
                                                  // }
                                                  // ;
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text("${_todo.progress}%"),
                                            ),
                                          ),
                                          SizedBox(width: 2.5),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Text("N/A"),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text(
                                                (_todo.note!.length >= 7)
                                                    ? (_todo.note!
                                                            .substring(0, 7) +
                                                        "...")
                                                    : (_todo.note!),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child:
                                                  (_todo.updatedDate != null &&
                                                          _todo.updatedDate!
                                                              .isNotEmpty &&
                                                          _todo.updatedDate!
                                                                  .length >
                                                              7)
                                                      ? Text(_todo.updatedDate!
                                                          .substring(0, 7))
                                                      : Text("N/A"),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: PopupMenuButton<int>(
                                                  icon: Icon(
                                                    Icons
                                                        .more_vert_outlined,
                                                    color:
                                                        kPrimaryColor,
                                                  ),
                                                  elevation: 0.0,
                                                  splashRadius: 1.0,
                                                  position:
                                                      PopupMenuPosition
                                                          .under,
                                                  itemBuilder:
                                                      (context) => [
                                                    PopupMenuItem<
                                                        int>(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .edit,
                                                              color:
                                                                  kPrimaryColor),
                                                          SizedBox(
                                                              width:
                                                                  8),
                                                          Text(
                                                              "Update")
                                                        ],
                                                      ),
                                                      value: 0,
                                                    ),
                                                    PopupMenuItem<
                                                        int>(
                                                      child: Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .delete,
                                                                color:
                                                                    kPrimaryColor),
                                                            SizedBox(
                                                                width:
                                                                    8),
                                                            Text(
                                                                "Delete")
                                                          ]),
                                                      value: 1,
                                                    ),
                                                  ],
                                                  onSelected: (value) {
                                                                  switch (
                                                                      value) {
                                                                    case 0:
                                                                      setState(
                                                                          () {
                                                                            if (!mounted){
                                                                              return;
                                                                            }
                                                                        _ed = 3;
                                                                        todoModel = notifier
                                                                            .todoData!
                                                                            .data![index];
                                                                        _scaffoldKey
                                                                            .currentState
                                                                            ?.openEndDrawer();
                                                                      });
                                                                      break;
                                                                    case 1:
                                                                      Alert(
                                                                        context:
                                                                            context,
                                                                        type: AlertType
                                                                            .warning,
                                                                        title:
                                                                            "Comfirmation",
                                                                        desc:
                                                                            "Are you sure you want to delete this todo?",
                                                                        buttons: [
                                                                          DialogButton(
                                                                            child:
                                                                                Text(
                                                                              "No",
                                                                              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                            ),
                                                                            onPressed: () =>
                                                                                Navigator.pop(context),
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                          DialogButton(
                                                                            child:
                                                                                Text(
                                                                              "Yes",
                                                                              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              String tripId = widget.folder.sId!;
                                                                              String actionId = _todo.sId!;
                                                                              var response = await deleteTodo(tripId, actionId);
                                                                              if (response == 200) {
                                                                                setState(() {
                                                                                  if(mounted){
                                                                                  notifier.todoData!.data!.removeAt(index);
                                                                                  }
                                                                                });
                                                                                Get.snackbar(
                                                                                  "Successed",
                                                                                  "This todo has been deleted.",
                                                                                  colorText: Colors.white,
                                                                                  snackPosition: SnackPosition.TOP,
                                                                                  margin: EdgeInsets.only(left: 1230),
                                                                                  maxWidth: 300,
                                                                                  backgroundColor: Colors.green,
                                                                                  duration: Duration(seconds: 3),
                                                                                  overlayColor: kPrimaryColor,
                                                                                );
                                                                                Navigator.pop(context);
                                                                                print("Done");
                                                                              }
                                                                            },
                                                                            color:
                                                                                Colors.green,
                                                                          )
                                                                        ],
                                                                      ).show();
                                                                      break;
                                                                  }
                                                                },
                                                              ),
                                                ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            child = Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 190,
                                height: 190,
                                child: Image.asset(
                                    "../../../../../assets/images/98560-empty.gif"),
                              ),
                            );
                          }
                          return child;
                        }),
                      ),
                      Consumer<TodoProvider>(builder: (__, notifier, child) {
                      List<List<int>> listPage = [];
                      List<int> storeIndexPage = [];
                      if (notifier.todoData != null &&
                          notifier.todoData!.data != null &&
                          notifier.todoData!.data!.isNotEmpty) {
                        if (listPage == [] ||
                            listPage.isEmpty && storeIndexPage == [] ||
                            storeIndexPage.isEmpty) {
                          for (var i = 0;
                              i < notifier.todoData!.totalPages!;
                              i++) {
                            if (i == 0) {
                              storeIndexPage.add(i + 1);
                            } else if (i % 8 == 0) {
                              listPage.add(storeIndexPage);
                              storeIndexPage = [];
                              storeIndexPage.add(i + 1);
                            } else {
                              storeIndexPage.add(i + 1);
                            }
                            if (i + 1 == notifier.todoData!.totalPages!) {
                              if (storeIndexPage.isNotEmpty) {
                                listPage.add(storeIndexPage);
                              }
                            }
                          }
                        }
                        child = Container(
                          width: 250,
                          child: Row(
                            children: [
                              (indexList > 0)
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (!mounted) {
                                            return;
                                          }
                                          indexList -= 1;
                                        });
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                          ),
                                          border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            right: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Icon(Icons
                                            .keyboard_double_arrow_left_sharp),
                                      ),
                                    )
                                  : Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9),
                                          bottomLeft: Radius.circular(9),
                                        ),
                                        border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          right: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          left: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Icon(Icons
                                          .keyboard_double_arrow_left_sharp),
                                    ),
                              (listPage == [] ||
                                      listPage.isEmpty &&
                                          storeIndexPage == [] ||
                                      storeIndexPage.isEmpty)
                                  ? (Container(color: Colors.white))
                                  : Row(
                                      children: List.generate(
                                        listPage[indexList].length,
                                        (index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (!mounted) {
                                                  return;
                                                }
                                                page =
                                                    listPage[indexList][index];
                                              });
                                              String? folderId = getFolder!.sId!;
                                              Provider.of<TodoProvider>(
                                                      context,
                                                      listen: false)
                                                  .getTodoData(folderId, page);
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                  right: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                  left: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                              ),
                                              child: Text(
                                                  "${listPage[indexList][index]}"),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              (notifier.todoData!.totalPages! >
                                          listPage[indexList].length &&
                                      listPage[indexList].length == 8)
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (!mounted) {
                                            return;
                                          }
                                          indexList = indexList + 1;
                                        });
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(9),
                                            bottomRight: Radius.circular(9),
                                          ),
                                          border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            right: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Icon(Icons
                                            .keyboard_double_arrow_right_sharp),
                                      ),
                                    )
                                  : Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(9),
                                          bottomRight: Radius.circular(9),
                                        ),
                                        border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          right: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          left: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Icon(Icons
                                          .keyboard_double_arrow_right_sharp),
                                    ),
                            ],
                          ),
                          // ),
                        );
                      } else {
                        child = Container(color: Colors.white);
                      }
                      return child;
                    }),
                    SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
