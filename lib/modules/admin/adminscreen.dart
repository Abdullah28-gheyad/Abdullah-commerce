import 'package:abdallagheyad/layout/home/cubit/cubit.dart';
import 'package:abdallagheyad/layout/home/cubit/states.dart';
import 'package:abdallagheyad/modules/login/loginscreen.dart';
import 'package:abdallagheyad/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController idController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController saleController = TextEditingController();

  TextEditingController stockController = TextEditingController();

  var formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddProductSuccessState)
          {
            Fluttertoast.showToast(
                msg: 'Product is added successfully' ,
              fontSize: 18 ,
              backgroundColor: Colors.green ,
              textColor: Colors.white
            ) ;
            nameController.text='';
            priceController.text='';
            saleController.text='';
            descriptionController.text='';
            stockController.text='';
            idController.text='';
          }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.logout),onPressed: (){navigateToAndRemove(context, LoginScreen());},),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_G_VhVyIITJlmKMW_QSlhsJR9S5jlsp2LTA&usqp=CAU'),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(context: context,
                                        builder: (context){
                                      return AlertDialog(
                                        title: Text('Choose option'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  cubit.uploadImageFromCamera();
                                                },
                                                 child: Row(
                                                   children: [
                                                     Icon(Icons.camera) ,
                                                     SizedBox(width: 5,) ,
                                                     Text('Camera')
                                                   ],
                                                 ),
                                              ),
                                              SizedBox(height: 10,),
                                              InkWell(
                                                onTap: (){},
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.image) ,
                                                    SizedBox(width: 5,) ,
                                                    Text('Gallery')
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      );
                                        });

                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          customTextFormField(
                              controller: nameController,
                              function: (String value) {
                                if (value.isEmpty)
                                  return 'Product name cannot be empty';
                                return null;
                              },
                              label: 'Product Name',
                              type: TextInputType.text,
                              prefixIcon: Icons.drive_file_rename_outline),
                          SizedBox(
                            height: 10,
                          ),
                          customTextFormField(
                            controller: idController,
                            function: (String value) {
                              if (value.isEmpty)
                                return 'product id cannot be empty';
                              return null;
                            },
                            label: 'Product ID',
                            type: TextInputType.number,
                            prefixIcon: Icons.perm_identity,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          customTextFormField(
                            controller: priceController,
                            function: (String value) {
                              if (value.isEmpty)
                                return 'Product price cannot be empty';
                              return null;
                            },
                            label: 'Product Price',
                            type: TextInputType.number,
                            prefixIcon: Icons.price_change,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          customTextFormField(
                              controller: descriptionController,
                              function: (String value) {
                                if (value.isEmpty)
                                  return 'Product description cannot be empty';
                                return null;
                              },
                              label: 'Product Description',
                              type: TextInputType.text,
                              prefixIcon: Icons.description_outlined),
                          SizedBox(
                            height: 10,
                          ),
                          customTextFormField(
                              controller: saleController,
                              function: (String value) {
                                if (value.isEmpty) return null;
                                return null;
                              },
                              label: 'Product Sale',
                              type: TextInputType.number,
                              prefixIcon: Icons.money_off),
                          SizedBox(
                            height: 10,
                          ),
                          customTextFormField(
                              controller: stockController,
                              function: (String value) {
                                if (value.isEmpty)
                                  return 'Product Stock cannot be empty';
                                return null;
                              },
                              label: 'Product Stock',
                              type: TextInputType.number,
                              prefixIcon: Icons.more_outlined),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            builder: (BuildContext context)=> customButton(
                                function: () {
                                  if (formKey.currentState.validate())
                                    {
                                      cubit.addProduct(name: nameController.text, price: priceController.text, description: descriptionController.text, stock: stockController.text,sale: saleController.text==''?null:saleController.text,id: idController.text) ;
                                    }
                                },
                                text: 'ADD PRODUCT'),
                            condition: state is !AddProductLoadingState,
                            fallback: (context)=>Center(child: CircularProgressIndicator()),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
