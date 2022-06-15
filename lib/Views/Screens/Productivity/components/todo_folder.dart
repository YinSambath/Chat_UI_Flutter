import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/Providers/folder_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_folders.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class TodoList extends StatefulWidget {
  Function(FolderModel)? callback;
  TodoList({
    Key? key,
    this.callback,
  }) : super(key: key);
  // FolderModel seletedFolder;
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int _d = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FolderProvider>(context, listen: false).getFolderData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1095,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CreateFolder(),
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
                  Text("Todo List"),
                  SizedBox(height: 12),
                  Row(
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
                            final response = await searchFolder(search);
                            if (response != null) {
                              Provider.of<FolderProvider>(context,
                                      listen: false)
                                  .getSearchFolder(search);
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11.0)),
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
                      SizedBox(width: 650),
                      ElevatedButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Text("New List"),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("New Todo"),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Container(
                width: 1095,
                height: 570,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(11)),
                child: Consumer<FolderProvider>(builder: (__, notifier, child) {
                  if (notifier.state == NotifierState.loading) {
                    child = const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  } else if (notifier.folderData != null &&
                      notifier.folderData!.data!.isNotEmpty &&
                      notifier.state == NotifierState.loaded) {
                    child = ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: notifier.folderData!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        FolderModel _folder = notifier.folderData!.data![index];
                        return Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(1),
                              Container(
                                width: 1095,
                                height: 70,
                                alignment: Alignment.center,
                                child: ListTile(
                                  leading: Container(
                                    width: 10,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: kPrimaryColor),
                                  ),
                                  title: Text("${_folder.name}"),
                                  trailing: Text(
                                    "GFG",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  ),
                                  subtitle: Text("10Tasks"),
                                  onTap: () async {
                                    String? folderId = _folder.sId;
                                    int page = 1;
                                    var response = await listTodo(folderId!, page);
                                    if (!mounted) return;
                                    (response != null)
                                        ? (setState(() {
                                            widget.callback!(notifier
                                                .folderData!.data![index]);
                                          }))
                                        : Get.snackbar(
                                            "Failed", "Please Try again",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    child = const Center(child: Text("No data"));
                  }
                  return child;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
