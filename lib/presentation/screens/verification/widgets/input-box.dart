import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chat/data/bloc/verification/verification_bloc.dart';
import 'package:happy_chat/data/bloc/verification/verification_event.dart';
import 'package:happy_chat/utilities/constants.dart';
import 'package:happy_chat/utilities/globals.dart' as globals;

class InputBox extends StatefulWidget {
  final TextEditingController controller;
  final bool lastChild;
  final bool firstChild;
  const InputBox({
    Key? key,
    required this.controller,
    this.lastChild = false,
    this.firstChild = false,
  }) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  FocusNode _focus = new FocusNode();
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: TextFormField(
        focusNode: _focus,
        controller: widget.controller,
        maxLength: 1,
        onChanged: (value) {
          setState(() {
            if (value.isNotEmpty) {
              globals.code = globals.code + value.toString();
              if (!widget.lastChild) {
                FocusScope.of(context).nextFocus();
              } else {
                BlocProvider.of<VerificationBloc>(context)
                    .add(Verification(globals.code));
              }
            } else if (value.isEmpty) {
              List<String> c = globals.code.split("");
              c.removeLast();
              globals.code = c.join();
              if (!widget.firstChild) {
                FocusScope.of(context).previousFocus();
              }
            }
            if (widget.lastChild) {
              print(globals.code);
            }
          });
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Constants.kFocusedBorderColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Constants.kBorderColor),
            borderRadius: BorderRadius.circular(Constants.kBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Constants.kFocusedBorderColor),
            borderRadius: BorderRadius.circular(Constants.kBorderRadius),
          ),
        ),
      ),
    );
  }
}
