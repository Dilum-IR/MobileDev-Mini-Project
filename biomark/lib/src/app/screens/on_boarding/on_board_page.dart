import 'package:flutter/material.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({
    Key? key,
    required this.color,
    required this.image,
    required this.title,
    required this.sub_title,
  }) : super(key: key);

  final String image;
  final String title;
  final String sub_title;
  final Color color;

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    animation();
    super.initState();
  }

  void animation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    fadeAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: widget.color,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          FadeTransition(
            opacity: fadeAnimation,
            child: Container(
              height: size.height / 2.5,
              width: size.width /1.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    )
                  ]
                  ,
                image: DecorationImage(
                  image: AssetImage(
                    widget.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.sub_title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    // decoration: TextDecoration.overline,
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
