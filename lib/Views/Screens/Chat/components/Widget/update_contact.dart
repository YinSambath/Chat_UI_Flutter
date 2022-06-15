import 'package:flutter/services.dart';
import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Providers/contact_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UpdateContact extends StatefulWidget {
  UpdateContact({Key? key, required this.contact}) : super(key: key);
  final ContactModel contact;
  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  late ContactProvider userId;
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _firstname.text = widget.contact.firstname ?? "";
    _lastname.text = widget.contact.lastname ?? "";
    _phone.text = widget.contact.phone ?? "";
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ContactProvider>(context, listen: false).getContactData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Drawer(
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
                                    String sId = widget.contact.sId!;
                                    String firstname = _firstname.text;
                                    String lastname = _lastname.text;
                                    String phone = _phone.text;
                                    var response = await updateContact(
                                        sId, firstname, lastname, phone);
                                    if (response != null) {
                                      Get.snackbar(
                                          "Done", "Contact has been update.");
                                      Provider.of<ContactProvider>(context,
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
                            "Update contact",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          child: Text(
                            "",
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 350,
                              height: 40,
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: _firstname,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Firstname",
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
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 350,
                              height: 40,
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: _lastname,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Lastname",
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
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text("Mobile "),
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          width: 400,
                          height: 50,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _phone,
                            onChanged: (value) {},
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: "Phone number",
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
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
