import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Providers/user_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:provider/provider.dart';

class Resume extends StatefulWidget {
  Resume({Key? key}) : super(key: key);

  @override
  State<Resume> createState() => _ResumeState();
}
  enum MediaType {
  image,
  video,
  file
}
class _ResumeState extends State<Resume> {
  final backgroundColor = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  PlatformFile? file;
  // final PrefService _prefs = PrefService();
  late int index;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).getDataUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<UserProvider>(builder: (__, notifier, child) {
        if (notifier.userData == null &&
            notifier.state == NotifierState.loading) {
          child = const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else if (notifier.userData != null &&
            notifier.state == NotifierState.loaded) {
          UserModel _user = notifier.userData!;
          child = SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            child: Container(
              width: 810,
              child: Scrollbar(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 800,
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Resume",
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // container for Put chat name or group name
                        Container(
                          height: 300,
                          width: 800,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                "../../../../assets/images/cover.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () {
                                // pickMedia(ImageSource.gallery);
                              },
                              icon: SvgPicture.asset(
                                '../../../../assets/icons/camera.svg',
                              ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          height: 100,
                          width: 800,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 100,
                                        backgroundImage: (_user.userProfile != null) 
                                                ? Image.network("http://localhost:3000/uploads/${_user.userProfile}").image
                                                : NetworkImage("https://img.favpng.com/2/21/11/computer-icons-user-profile-user-account-clip-art-png-favpng-gDBjftHWJPTMjttnBiJh9vw96.jpg"),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child:
                                            InkWell(
                                              child: SvgPicture.asset("icons/plus.svg"),
                                              onTap: () async {
                                                FilePickerResult? result = await FilePicker.platform.pickFiles(withReadStream: true);
                                                setState(() {
                                                  if (result != null) {
                                                    file = result.files.first;
                                                    print(file!.name);
                                                    // print(file.bytes);
                                                    print(file!.size);
                                                    print(file!.extension);
                                                  } 
                                                });
                                                var response = await uploadOrUpdateImage(file!);
                                                if (response == 200) {
                                                  Get.snackbar("Success", "You have uploaded new profile.",
                                                    colorText: Colors.white,
                                                    snackPosition: SnackPosition.TOP,
                                                    margin: EdgeInsets.only(left: 1230),
                                                    maxWidth: 300,
                                                    backgroundColor: Colors.green,
                                                    duration: Duration(seconds: 3),
                                                    overlayColor: kPrimaryColor);
                                                    Provider.of<UserProvider>(context, listen: false).getDataUser();
                                                }
                                              },
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${_user.username}",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 700,
                          width: 800,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "personal_information".tr,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        height: 500,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("full_name".tr),
                                            Text("user_name".tr),
                                            Text("phone_number".tr),
                                            Text("email".tr),
                                            Text("date_of_birth".tr),
                                            Text("gender".tr),
                                            Text("nationality".tr),
                                            Text("marital_status".tr),
                                            Text("address".tr),
                                            Text("website".tr),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 45),
                                      Container(
                                        width: 300,
                                        height: 500,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (_user.firstname! +
                                                  " " +
                                                  _user.lastname!),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              _user.username!,
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              _user.phone!,
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              (_user.email! != "")
                                                  ? (_user.email!)
                                                  : ("N/A"),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              (_user.dob! != "")
                                                  ? (_user.dob!)
                                                  : ("N/A"),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              (_user.gender! != "")
                                                  ? (_user.gender!)
                                                  : ("N/A"),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              (_user.nationality! != "")
                                                  ? (_user.nationality!)
                                                  : ("N/A"),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              (_user.status! != "")
                                                  ? (_user.status!)
                                                  : ("N/A"),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              (_user.address! != "")
                                                  ? (_user.address!)
                                                  : ("N/A"),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              (_user.website! != "")
                                                  ? (_user.email!)
                                                  : ("N/A"),
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          );
        } else {
          child = const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }
        return child;
      }),
    );
  }
}
