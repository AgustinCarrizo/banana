import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {
  final String text;
  final Function()? ontop;
  const ButtonAction({super.key, required this.text, required this.ontop});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.purple),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero))),
            ),
            onPressed: ontop,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
