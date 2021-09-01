import 'package:abdallagheyad/layout/home/cubit/cubit.dart';
import 'package:abdallagheyad/layout/home/cubit/states.dart';
import 'package:abdallagheyad/models/productmodel.dart';
import 'package:abdallagheyad/modules/productdetails/productdetailsscreen.dart';
import 'package:abdallagheyad/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.products!=null,
          builder: (BuildContext context)=>SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      physics: BouncingScrollPhysics(),
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      children:List.generate(
                          cubit.products.length,
                              (index) => buildProductItem(
                              cubit.products[index],context,index))

                    ),
                  )
                ],
              )),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProductItem(ProductModel productModel,context,index) => InkWell(
    onTap: (){
      navigateTo(context, ProductDetails(productModel: productModel,index: index,));
    },
    child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Image(
                image: NetworkImage(
                  productModel.image
                ),
                width: double.infinity,
                height: 200,
                fit: BoxFit.fill,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      productModel.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      productModel.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        if (productModel.sale !='')
                             Expanded(
                            child: Text(
                          productModel.sale,
                          style: TextStyle(color: Colors.green),
                        )),
                        if (productModel.sale !='')
                           Expanded(
                            child: Text(
                          productModel.price,
                          style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        )),
                        if (productModel.sale =='')
                              Expanded(
                            child: Text(
                          productModel.price,
                          style: TextStyle(color: Colors.black),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
  );
}
