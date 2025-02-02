import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/presentation/starting_page.dart';
import 'package:rapid_rounds/features/room/data/firebase_room_repo.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'package:rapid_rounds/firebase_options.dart';

void main() async {
  //load env variables
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final roomRepo = FirebaseRoomRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //room cubit
        BlocProvider(
          create: (context) => RoomCubit(roomRepo: roomRepo),
        ),
      ],
      child: MaterialApp(
        // scrollBehavior: ScrollConfiguration.of(context).copyWith(
        //   dragDevices: {
        //     PointerDeviceKind.touch,
        //     PointerDeviceKind.mouse,
        //   },
        // ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Abel',
          scaffoldBackgroundColor: GColors.scaffoldBg,
          appBarTheme: AppBarTheme(
            backgroundColor: GColors.appBarBg,
          ),
        ),
        home: StartingPage(),
      ),
    );
  }
}
