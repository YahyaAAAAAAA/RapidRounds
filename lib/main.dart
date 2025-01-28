import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rapid_rounds/features/room/data/firebase_room_repo.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'package:rapid_rounds/firebase_options.dart';
import 'package:rapid_rounds/features/home/presentation/home_page.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Abel',
          scaffoldBackgroundColor: Color(0xFFf5f4ed),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
