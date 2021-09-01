import 'package:abdallagheyad/models/usermodel.dart';
import 'package:abdallagheyad/modules/register/cubit/states.dart';
import 'package:abdallagheyad/shared/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  UserModel userModel;

  void userRegisterWithEmail({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterWithEmailLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          uId = value.user.uid ;
      userCreate(email: email, password: password, name: name, phone: phone, uId: value.user.uid) ;
    })
        .catchError((error) {
      print('Iam the error'+error.toString());
      emit(RegisterWithEmailErrorState());
    });
  }

  void userCreate({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
    @required String uId,
  }) {
    userModel = UserModel(
        uId: uId, email: email, password: password, phone: phone, name: name,image: 'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print('second error'+error.toString());
      emit(CreateUserErrorState());
    });
  }
}
