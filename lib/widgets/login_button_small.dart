import 'package:flutter/material.dart';

class LoginButtonSmall extends StatelessWidget {
  const LoginButtonSmall(
    this.buttonText,
    this.onTapFunction, {
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onTapFunction(),
        child: Text(buttonText),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).scaffoldBackgroundColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
              side: const BorderSide(
                color: Color.fromRGBO(79, 79, 79, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
