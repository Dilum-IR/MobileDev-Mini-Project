import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: Align(
          alignment: Alignment.center,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext ctx, index) {
                int timer = 1500;
                return Shimmer.fromColors(
                  enabled: true,
                  baseColor: Colors.orangeAccent.withOpacity(0.4),
                  highlightColor: Colors.orangeAccent.withOpacity(0.6),
                  // direction: ShimmerDirection.ttb,
                  period: Duration(milliseconds: timer),
                  child: box(),
                );
              }),
        ),
      ),
    );
  }

  Widget box() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
