import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chat/data/bloc/signup/signup_bloc.dart';
import 'package:happy_chat/data/bloc/signup/signup_event.dart';
import 'package:happy_chat/data/bloc/signup/signup_state.dart';
import 'package:happy_chat/utilities/constants.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Color buttonColor = Constants.kFocusedBorderColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "هپی چت",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Constants.kTextColor,
                      fontFamily: 'Dana',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 42),
                  child: Text(
                    "برای ثبت نام شماره تلفن خود را وارد نمایید.",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Constants.kTextColor),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 16),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.length < 11)
                          return "به نظر می آید شماره تلفن معتبری وارد نکرده اید، مجددا تلاش کنید";
                      },
                      controller: numberController,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.phone,
                      //cursorHeight: 3.2,
                      maxLength: 13,
                      style: TextStyle(
                        color: Constants.kFocusedBorderColor,
                        fontSize: 17,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        CustomInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        counterText: "",
                        fillColor: Colors.white,
                        //focusColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.kBorderColor),
                          borderRadius:
                              BorderRadius.circular(Constants.kBorderRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Constants.kFocusedBorderColor),
                          borderRadius:
                              BorderRadius.circular(Constants.kBorderRadius),
                        ),
                        hintText: "شماره تلفن خود را وارد نمایید",
                        hintStyle: TextStyle(
                          color: Constants.kBorderColor,
                        ),
                        prefixIcon: Container(
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Constants.kBorderColor),
                            ),
                          ),
                          child: Image.asset("assets/flag.png"),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.kErrorColor),
                          borderRadius:
                              BorderRadius.circular(Constants.kBorderRadius),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.kErrorColor),
                          borderRadius:
                              BorderRadius.circular(Constants.kBorderRadius),
                        ),
                        errorStyle: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty)
                            buttonColor = Constants.kFocusedBorderColor;
                          else
                            buttonColor = Colors.black;
                        });
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<SignupBloc>(context).add(SignUp(int.parse(
                          numberController.text
                              .replaceAll(new RegExp(r"\s+"), ""))));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 54,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.kBorderRadius),
                      ),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 200),
                    child: Center(
                        child: BlocConsumer<SignupBloc, SignUpState>(
                      listener: (context, state) {
                        if (state is SuccessSignUpState) {
                          Navigator.of(context).pushNamed('/verification');
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadingSignUpState)
                          return CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          );
                        else
                          return Text(
                            "ثبت نام",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          );
                      },
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex == 4 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
      if (nonZeroIndex == 7 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
      if (nonZeroIndex == 11 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
