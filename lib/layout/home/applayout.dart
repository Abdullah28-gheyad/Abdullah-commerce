import 'package:abdallagheyad/layout/home/cubit/cubit.dart';
import 'package:abdallagheyad/layout/home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context) ;
        return Scaffold(
          backgroundColor: Colors.grey[200],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeNavBar(index) ;
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home') ,
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart') ,
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite') ,
            ],
          ),
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
        ) ;
      },
    );
  }
}
