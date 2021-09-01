import 'package:abdallagheyad/layout/home/cubit/cubit.dart';
import 'package:abdallagheyad/modules/login/loginscreen.dart';
import 'package:abdallagheyad/shared/blocobserver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await Firebase.initializeApp() ;
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..getProducts()..getFavoriteProducts()..getCartProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white ,
            elevation: 0.0,
            titleTextStyle: TextStyle(color: Colors.black , fontSize: 20) ,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white
            ),
            toolbarTextStyle: TextStyle(
              color: Colors.black
            ),
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            backwardsCompatibility: false ,
            centerTitle: false ,

          ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.blue ,
              unselectedItemColor: Colors.grey ,
              elevation: 15 ,
              backgroundColor: Colors.white ,
              selectedIconTheme: IconThemeData(
                  color: Colors.black
              ),
              unselectedIconTheme: IconThemeData(
                  color: Colors.grey
              ),

            )
        ),
        home: LoginScreen(),
      ),
    );
  }
}