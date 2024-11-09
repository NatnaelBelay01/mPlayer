import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('images/a.jpg'),
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              children: [
                Text(
                  "Remedy",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Annie Schindel",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
