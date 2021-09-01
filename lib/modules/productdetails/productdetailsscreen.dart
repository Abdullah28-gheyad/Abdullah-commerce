import 'package:abdallagheyad/layout/home/cubit/cubit.dart';
import 'package:abdallagheyad/layout/home/cubit/states.dart';
import 'package:abdallagheyad/models/productmodel.dart';
import 'package:abdallagheyad/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel productModel;
  final int index;

  ProductDetails({this.productModel, this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddToCartSuccessState) {
          Fluttertoast.showToast(
              msg: 'Product is added to cart success',
              textColor: Colors.white,
              backgroundColor: Colors.green);
        }
        if (state is AddToFavoriteSuccessState) {
          Fluttertoast.showToast(
              msg: 'Product is added to favorite success',
              textColor: Colors.white,
              backgroundColor: Colors.green);
        }
        if (state is RemoveProductFromFavoriteSuccessState) {
          Fluttertoast.showToast(
              msg: 'Product is removed from favorite success',
              textColor: Colors.white,
              backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Product Details'),
            leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
              cubit.favIcon = Icons.favorite_border ;
              Navigator.pop(context) ;
            },),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image(
                    image: NetworkImage(productModel.image),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  productModel.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                    child: Text(
                  productModel.description,
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    if (productModel.sale != '')
                      Expanded(
                          child: Text(
                        productModel.sale,
                        style: TextStyle(color: Colors.green),
                      )),
                    if (productModel.sale != '')
                      Expanded(
                          child: Text(
                        productModel.price,
                        style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough),
                      )),
                    if (productModel.sale == '')
                      Expanded(
                          child: Text(
                        productModel.price,
                        style: TextStyle(color: Colors.black),
                      )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: customButton(function: () {
                          cubit.addToCart(productModel: productModel) ;
                        }, text: 'CART')),
                    Expanded(
                      child: IconButton(
                          onPressed: () {
                            cubit.changeFavIcon(productModel: productModel);
                          },
                          icon: Icon(cubit.favIcon,size: 30,)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
