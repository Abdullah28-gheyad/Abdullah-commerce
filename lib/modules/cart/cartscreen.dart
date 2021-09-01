import 'package:abdallagheyad/layout/home/cubit/cubit.dart';
import 'package:abdallagheyad/layout/home/cubit/states.dart';
import 'package:abdallagheyad/models/productmodel.dart';
import 'package:abdallagheyad/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context) ;
        return  ConditionalBuilder(
          condition: cubit.cartProducts!=null,
          builder: (BuildContext context)=>SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (cubit.cartProducts.length==0)
                        Expanded(
                          child: Image(
                            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzibBVD9w_go7Ofo5BK44_ufJf_y7qQAoPKg&usqp=CAU'),
                          ),
                        ) ,
                    if (cubit.cartProducts.length!=0)
                         SizedBox(
                      height: 30,
                    ),
                    if (cubit.cartProducts.length!=0)
                         Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => cartItem(
                            cubit.cartProducts[index] ,index , context ,
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: cubit.cartProducts.length),
                    ),
                        Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                            Text('\$ ${cubit.resultTotal}',
                                            style: TextStyle(color: Colors.green)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child:
                                    customButton(function: () {
                                      if (cubit.resultTotal==0)
                                        {
                                          Fluttertoast.showToast(msg: 'Cannot be Order Please Add Products' , textColor: Colors.white , backgroundColor: Colors.red) ;
                                        }
                                      else
                                        {
                                          //Navigateto(context, DeliveryDetails()) ;
                                        }
                                    }, text: 'CHECKOUT'))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
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
                    Text(
                      '\$ ${model.price}',
                      style: TextStyle(color: Colors.green),
                    ),
                    Spacer(),
                    Container(
                      color: Colors.grey[300],
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (int.parse(model.stock)>=AppCubit.get(context).counters[index])
                              IconButton(onPressed: () {
                            AppCubit.get(context).plusNumber(index);
                          }, icon: Icon(Icons.add)),
                          if (int.parse(model.stock)>=AppCubit.get(context).counters[index])
                              SizedBox(
                                width: 5,
                              ),
                          if (int.parse(model.stock)>=AppCubit.get(context).counters[index])
                              Text(AppCubit.get(context).counters[index].toString()),
                          if (int.parse(model.stock)>=AppCubit.get(context).counters[index])
                              SizedBox(
                                width: 5,
                              ),
                          if (int.parse(model.stock)>=AppCubit.get(context).counters[index])
                              IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).minNumber(index);
                                  }, icon: Icon(Icons.remove)),
                          if (int.parse(model.stock)<AppCubit.get(context).counters[index])
                            Expanded(
                              child: TextButton(onPressed: (){
                                AppCubit.get(context).returnToZero(index) ;
                              }, child: Text('The Stock is less than number')),
                            )

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ) ,
              Expanded(
                child: IconButton(
                    onPressed: (){
                      AppCubit.get(context).removeItemShopCart(productModel: model) ;
                    },
                    icon: Icon(Icons.close)
                ),
              )
            ],
          ),
        ),
      );
}
