import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Providers/folder_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateFolder extends StatelessWidget {
  CreateFolder({Key? key}) : super(key: key);
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    String name = _name.text;
                                    var response = await createFolder(name);
                                    if (response != null) {
                                      Get.snackbar(
                                          "Successed", "You have created todo.",
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP,
                                          margin: EdgeInsets.only(left: 1230),
                                          maxWidth: 300,
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 3),
                                          overlayColor: kPrimaryColor);
                                      Provider.of<FolderProvider>(context,
                                              listen: false)
                                          .createUpdate(response);
                                      Navigator.of(context).pop();
                                      _name.clear();
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
                            "New folder",
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
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        enabled: true,
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.red),
                          borderRadius: BorderRadius.circular(11),
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
  }
}
