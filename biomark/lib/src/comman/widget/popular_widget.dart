import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/controllers/user/shared_auth_user.dart';
import '../../app/screens/auth/signin_screen.dart';
import '../../utils/colors/colors.dart';
import '../../utils/helper/device.dart';
import '../../utils/helper/user_handler.dart';

class PopularWidget extends StatefulWidget {
  final element;

  const PopularWidget({
    super.key,
    required this.element,
  });

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  dynamic _selectedIndex;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = -1;
          if (_selectedIndex == widget.element) {
            // _selectedIndex = {};
          } else {
            _selectedIndex = widget.element;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: _selectedIndex == widget.element
                ? Border.all(color: KColors.primaryColor, width: 1)
                : null,
            boxShadow: _selectedIndex == widget.element
                ? [
                    BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 5,
                        offset: const Offset(0, 0))
                  ]
                : [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 5))
                  ]),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Icon(
                  widget.element.icon,
                  color: Colors.blue,
                  size: 40,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  UserHandler.capitalizeFirstLetter(
                      widget.element.name),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.blue,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.element.description.toString(),
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      color: Colors.grey.shade600),
                  maxLines: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
