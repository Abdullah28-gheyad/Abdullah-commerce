import 'package:abdallagheyad/layout/home/applayout.dart';
import 'package:abdallagheyad/modules/register/cubit/cubit.dart';
import 'package:abdallagheyad/modules/register/cubit/states.dart';
import 'package:abdallagheyad/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState)
            {
              navigateToAndRemove(context, LayoutScreen()) ;
            }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customTextFormField(
                          controller: nameController,
                          function: (String value) {
                            if (value.isEmpty) return 'name cannot be empty';
                            return null;
                          },
                          secure: false,
                          label: 'Name',
                          prefixIcon: Icons.person,
                          type: TextInputType.text,
                        ),
                        SizedBox(height: 10,),
                        customTextFormField(
                          controller: emailController,
                          function: (String value) {
                            if (value.isEmpty) return 'email cannot be empty';
                            return null;
                          },
                          secure: false,
                          label: 'Email',
                          prefixIcon: Icons.email,
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customTextFormField(
                          controller: passwordController,
                          function: (String value) {
                            if (value.isEmpty) return 'password cannot be empty';
                            return null;
                          },
                          secure: true,
                          label: 'Password',
                          prefixIcon: Icons.lock,
                          type: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customTextFormField(
                          controller: phoneController,
                          function: (String value) {
                            if (value.isEmpty) return 'phone cannot be empty';
                            return null;
                          },
                          secure: false,
                          label: 'Phone',
                          prefixIcon: Icons.phone,
                          type: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          builder: (BuildContext context)=>customButton(function: () {
                            if (formKey.currentState.validate())
                            {
                              cubit.userRegisterWithEmail(email: emailController.text, password: passwordController.text,name: nameController.text,phone: phoneController.text) ;
                            }
                          }, text: 'SIGN UP'),
                          condition: state is!RegisterWithEmailLoadingState,
                          fallback: (context)=>Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
