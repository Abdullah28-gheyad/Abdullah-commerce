


import 'dart:io';

import 'package:abdallagheyad/layout/home/cubit/states.dart';
import 'package:abdallagheyad/models/productmodel.dart';
import 'package:abdallagheyad/modules/cart/cartscreen.dart';
import 'package:abdallagheyad/modules/favorite/favoritescreen.dart';
import 'package:abdallagheyad/modules/home/homescreen.dart';
import 'package:abdallagheyad/shared/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
  ];
  List<String> titles = [
    'Home',
    'Cart',
    'Favorites',
  ];

  void changeNavBar(int index) {
    if (index == 1) getCartProducts();
    if (index == 2) getFavoriteProducts();
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  File image;
  final imagePicker= ImagePicker() ;
  uploadImageFromCamera()
  async {
    final XFile image = await imagePicker.pickImage(source: ImageSource.camera);
  }




  ProductModel productModel;
  void addProduct({
    @required String name,
    @required String price,
    @required String description,
    @required String id,
    String sale,
    String image,
    @required String stock,
  }) {
    productModel = ProductModel(
        description: description,
        image: image ??
            'https://image.shutterstock.com/image-vector/choose-product-online-color-icon-260nw-1536821891.jpg',
        name: name,
        price: price,
        sale: sale ?? '',
        stock: stock,
        id: id);
    emit(AddProductLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .set(productModel.toMap())
        .then((value) {
      emit(AddProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddProductErrorState());
    });
  }

  List<ProductModel> products;
  void getProducts() {
    emit(GetProductsLoadingState());
    FirebaseFirestore.instance.collection('products').get().then((value) {
      products = [];
      value.docs.forEach((element) {
        products.add(ProductModel.FromJson(element.data()));
      });
      emit(GetProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductErrorState());
    });
  }

  void addToFavorite({
    @required ProductModel productModel,
  }) {
    emit(AddToFavoriteLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorite')
        .doc(productModel.id)
        .set(productModel.toMap())
        .then((value) {
      emit(AddToFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddToFavoriteErrorState());
    });
  }


  List<ProductModel> favoriteProducts = [];
  void getFavoriteProducts() {
    favoriteProducts = [];
    emit(GetFavoriteLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorite')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        favoriteProducts.add(ProductModel.FromJson(element.data()));
      });
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteErrorState());
    });
  }

  void removeProductFromFavorite({@required ProductModel productModel}) {
    emit(RemoveProductFromFavoriteLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorite')
        .doc(productModel.id)
        .delete()
        .then((value) {
          getFavoriteProducts();
      emit(RemoveProductFromFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RemoveProductFromFavoriteErrorState());
    });
  }

  IconData favIcon = Icons.favorite_border;

  void changeFavIcon({@required ProductModel productModel}) {
    if (favIcon == Icons.favorite_border)
    {
      favIcon = Icons.favorite;
      addToFavorite(productModel: productModel);
    }
    else
    {
      favIcon = Icons.favorite_border;
      removeProductFromFavorite(productModel: productModel);
    }
    emit(ChangeIconButtonState());
  }

  List<ProductModel> cartProducts = [];

  double resultTotal;
  List<int> counters=[] ;
  void getCartProducts() {
    cartProducts = [];
    counters=[] ;
    resultTotal=0;
    emit(GetCartLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        counters.add(1) ;
        cartProducts.add(ProductModel.FromJson(element.data()));
        String check = element.data()['price'] ;
        resultTotal+=double.parse(check) ;
      });
      emit(GetCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartErrorState());
    });
  }

  // need some work
  void addToCart({
    @required ProductModel productModel,
  }) {
    emit(AddToCartLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(productModel.id)
        .set(productModel.toMap())
        .then((value) {
      emit(AddToCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartErrorState());
    });
  }


  void plusNumber(int index)
  {
    counters[index]++ ;
    calcTotal();
    emit(PlusNumberState()) ;
  }
  void minNumber(index)
  {
    if (counters[index]>1) {
      counters[index] -- ;
      calcTotal();
      emit(MinNumberState()) ;
    }
  }
  void calcTotal()
  {
    resultTotal=0 ;
    for (int i = 0 ; i<counters.length;i++)
    {
      resultTotal+=counters[i]*double.parse(cartProducts[i].price) ;
    }
    emit(CalcTotalState()) ;
  }

  void removeItemShopCart(
      {
        @required ProductModel productModel
      }
      )
  {
    emit(RemoveProductLoadingState()) ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(productModel.id)
        .delete()
        .then((value){
      getCartProducts() ;
    })
        .catchError((error){
      print (error.toString()) ;
      emit(RemoveProductErrorState()) ;
    });
  }


  void returnToZero(int index )
  {
    counters[index]=0;
    calcTotal();
  }

}
