import 'package:abdallagheyad/layout/home/cubit/cubit.dart';
import 'package:abdallagheyad/layout/home/cubit/states.dart';
import 'package:abdallagheyad/models/productmodel.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context) ;
        return  ConditionalBuilder(
          condition: cubit.favoriteProducts!=null,
          builder: (BuildContext context)=>SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (cubit.favoriteProducts.length==0)
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Icon(Icons.favorite,size: 100,) ,
                            Text('YOUR FAVORITE IS EMPTY',style: TextStyle(fontSize: 20),)
                          ],
                        ),
                      ) ,
                    if (cubit.favoriteProducts.length!=0)
                      SizedBox(
                        height: 30,
                      ),
                    if (cubit.favoriteProducts.length!=0)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => cartItem(
                              cubit.favoriteProducts[index] ,index , context ,
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemCount: cubit.favoriteProducts.length),
                      ),

                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Container(),

        );
      },

    );
  }

  Widget cartItem(ProductModel model,int index , context ) => Card(
    child: Container(
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(
                  model.image),
              height: 120,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),

                Row(
                  children: [
                    if (model.sale != '')
                      Expanded(
                          child: Text(
                            model.sale,
                            style: TextStyle(color: Colors.green),
                          )),
                    if (model.sale != '')
                      Expanded(
                          child: Text(
                            model.price,
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough),
                          )),
                    if (model.sale == '')
                      Expanded(
                          child: Text(
                            model.price,
                            style: TextStyle(color: Colors.black),
                          )),
                  ],
                ),
                Text(
                  '${model.description}',maxLines: 1,overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ) ,
          Expanded(
            child: IconButton(
                onPressed: (){
                  AppCubit.get(context).removeProductFromFavorite(productModel: model) ;
                },
                icon: Icon(Icons.favorite)
            ),
          )
        ],
      ),
    ),
  );
}
