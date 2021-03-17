import 'package:flutter/material.dart';

class MenuImage extends StatelessWidget {
  final String imageURL;
  final theImage = Image.network(
    "https://assets.rebelmouse.io/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpbWFnZSI6Imh0dHBzOi8vYXNzZXRzLnJibC5tcy8xODMxMjEwOC9vcmlnaW4uanBnIiwiZXhwaXJlc19hdCI6MTY1OTA1MTUzNH0.dDjYX4M1Cd7LyZz9HmD3sK7G7JmOc5XQZ9IO7uXdt-Q/img.jpg?width=980",
    fit: BoxFit.cover,
  );
  MenuImage(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: theImage,
    );
  }
}
