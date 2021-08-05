import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chat/data/bloc/verification/verification_bloc.dart';
import 'package:happy_chat/data/bloc/verification/verification_state.dart';
import 'package:happy_chat/presentation/screens/verification/widgets/input-box.dart';
import 'package:happy_chat/utilities/constants.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({Key? key}) : super(key: key);

  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Text(
                  "بازگشت",
                  style: TextStyle(
                    color: Constants.kTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Constants.kArrowBackIcon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Constants.kTextColor,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
        leading: Container(),
      ),
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
                        color: Constants.kTextColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 42),
                  child: Text(
                    "برای ثبت نام کد 4 رقمی ارسال شده را وارد نمایید.",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Constants.kTextColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputBox(
                      controller: controller1,
                      firstChild: true,
                    ),
                    InputBox(controller: controller2),
                    InputBox(controller: controller3),
                    InputBox(
                      controller: controller4,
                      lastChild: true,
                    ),
                  ],
                ),
                BlocConsumer<VerificationBloc, VerificationState>(
                  listener: (context, state) {
                    if (state is SuccessVerificationState) {
                      Navigator.of(context).popAndPushNamed('/home');
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingVerificationState) {
                      return CircularProgressIndicator(
                        color: Color(0xffF5DFD9),
                        backgroundColor: Color(0xffDA7E70),
                        strokeWidth: 1.5,
                      );
                    } else if (state is FailedVerificationState) {
                      return Column(
                        children: [
                          Text(
                            "کد وارد شده معتبر نمی باشد، مجددا تلاش نمایید",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Constants.kErrorColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "ارسال مجدد کد",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      );
                    } else
                      return Text(
                        "ارسال مجدد کد",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
