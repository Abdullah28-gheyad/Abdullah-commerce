import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextFormField({
  @required var controller,
  @required Function function,
  @required String label,
  IconData prefixIcon,
  var type = TextInputType.text,
  bool secure = false,
  Function onTap,
}) =>
    TextFormField(
      onTap: onTap,
      controller: controller,
      obscureText: secure,
      validator: function,
      keyboardType: type,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );

Widget customButton({
  @required Function function,
  @required String text,
  double width = double.infinity,
  double height = 50,
  Color color = Colors.green,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );

void navigateTo(context , widget){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget,),);
}
void navigateToAndRemove(context , widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget,),
        (Route<dynamic> route) => false,
  );
}
