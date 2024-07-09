import 'package:flutter/material.dart';

class AdminHomeCard extends StatelessWidget {
  const AdminHomeCard({
    Key? key,
    required this.image,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String image;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 80,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
