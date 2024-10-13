import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';

class UploadFileProgress extends StatefulWidget {
  final uploadTask;
  final double height;
  const UploadFileProgress(
      {super.key, required this.uploadTask, required this.height});

  @override
  State<UploadFileProgress> createState() => _UploadFileProgressState();
}

class _UploadFileProgressState extends State<UploadFileProgress> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TaskSnapshot>(
        stream: widget.uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return progress != 1.0
                ? Container(
                    height: widget.height,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        LinearProgressIndicator(
                          value: progress,
                          color: KColors.secondaryColor,
                          backgroundColor: KColors.primaryColor.withOpacity(0.3),
                        ),
                        Center(
                          child: Text(
                            "${(100 * progress).roundToDouble()} %",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container();
          } else {
            return const SizedBox();
          }
        });
  }
}
