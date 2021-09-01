import 'package:abdallagheyad/modules/login/cubit/states.dart';
import 'package:abdallagheyad/shared/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLoginWithEmail({
    @required String email,
    @required String password,
  }) {
    emit(LoginWithEmailLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          uId=value.user.uid;
      emit(LoginWithEmailSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginWithEmailErrorState());
    });
  }
}
