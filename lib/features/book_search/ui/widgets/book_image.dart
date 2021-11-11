import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  const BookImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset('assets/images/reading_vector.png'),
          ),
        ],
      ),
    );
  }
}
