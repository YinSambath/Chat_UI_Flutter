import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/Providers/folder_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';

// ignore: must_be_immutable
class UpdateFolder extends StatefulWidget {
  Function(String)? callback;
  final FolderModel dataFolder;
  UpdateFolder({
    Key? key,
    this.callback,
    required this.dataFolder,
  }) : super(key: key);
  @override
  State<UpdateFolder> createState() => _UpdateFolderState();
}

class _UpdateFolderState extends State<UpdateFolder> {
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  late TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _name.text = widget.dataFolder.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FolderProvider>(builder: (__, notifier, child) {
      if (notifier.state == NotifierState.loading) {
        child = const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      } else if (notifier.folderData != null &&
          notifier.folderData!.data!.isNotEmpty &&
          notifier.state == NotifierState.loaded) {
        child = Container(
          width: 400,
          child: Drawer(
            backgroundColor: Color.fromARGB(255, 250, 249, 249),
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        child: DrawerHeader(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final bool _isValid =
                                          _formKey.currentState!.validate();
                                      if (_isValid) {
                                        String sId = widget.dataFolder.sId!;
                                        String folderName = _name.text;
                                        var response =
                                            await updateFolder(sId, folderName);
                                        if (response != null) {
                                          Get.snackbar("Done",
                                              "Folder has been created.");
                                          widget.callback!(response.name);
                                          Provider.of<FolderProvider>(context,
                                                  listen: false)
                                              .createUpdate(response);
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Update Folder",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 400,
                        height: 50,
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _name,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Folder name...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                            enabled: true,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, color: Colors.red),
                              borderRadius: BorderRadius.circular(29),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        child = const Center(child: Text("No data"));
      }
      return child;
    });
  }
}
