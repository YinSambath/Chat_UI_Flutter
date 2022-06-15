// @dart=2.9
import 'package:mcircle_project_ui/Providers/action_meeting_provider.dart';
import 'package:mcircle_project_ui/Providers/action_planning_provider.dart';
import 'package:mcircle_project_ui/Providers/action_provider.dart';
import 'package:mcircle_project_ui/Providers/contact_provider.dart';
import 'package:mcircle_project_ui/Providers/folder_provider.dart';
import 'package:mcircle_project_ui/Providers/meeting_provider.dart';
import 'package:mcircle_project_ui/Providers/message_provider.dart';
import 'package:mcircle_project_ui/Providers/planning_provider.dart';
import 'package:mcircle_project_ui/Providers/todo_provider.dart';
import 'package:mcircle_project_ui/Providers/trip_provider.dart';
import 'package:mcircle_project_ui/Providers/user_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:mcircle_project_ui/helpers/translate.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAnjCOHeOlpvQHVtQHPDMTY12xiLgfqDeg',
        appId: '1:410852347601:web:47e930a31daaf429c8fff0',
        messagingSenderId: '410852347601',
        projectId: 'chatapp-79a63',
        authDomain: 'chatapp-79a63.firebaseapp.com',
        storageBucket: 'chatapp-79a63.appspot.com',
        measurementId: 'G-ZRB2DSQT56',
      ),
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ContactProvider>(
            create: (_) => ContactProvider()),
        ChangeNotifierProvider<FolderProvider>(create: (_) => FolderProvider()),
        ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider()),
        ChangeNotifierProvider<TripProvider>(create: (_) => TripProvider()),
        ChangeNotifierProvider<ActionProvider>(create: (_) => ActionProvider()),
        ChangeNotifierProvider<MeetingProvider>(
            create: (_) => MeetingProvider()),
        ChangeNotifierProvider<PlanningProvider>(
            create: (_) => PlanningProvider()),
        ChangeNotifierProvider<ActionMeetingProvider>(
            create: (_) => ActionMeetingProvider()),
        ChangeNotifierProvider<ActionPlanningProvider>(
            create: (_) => ActionPlanningProvider()),
        ChangeNotifierProvider<MessageProvider>(
            create: (_) => MessageProvider()),
      ],
      child: GetMaterialApp(
        initialRoute: "/SplashRoute",
        routes: routes,
        debugShowCheckedModeBanner: false,
        translations: LocalizationService(),
        locale: Locale('en', 'US'),
        title: 'Chat Application',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashView(),
      ),
    );
  }
}
