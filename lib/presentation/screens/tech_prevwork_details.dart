import 'package:repairo_app_new/core/constants/app_constants.dart';
import 'package:repairo_app_new/data/models/tech_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkDetailsPage extends StatelessWidget {
  final PreviousWorks work;
  const WorkDetailsPage({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            work.title!,
            style: const TextStyle(
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                work.description ?? '',
                style: const TextStyle(fontFamily: "Cairo", fontSize: 16),
              ),
              const SizedBox(height: 16),
              ...work.image!.map((imgUrl) {
                final fixedUrl = imgUrl.replaceFirst(
                  "127.0.0.1",
                  AppConstants.baseaddress,
                );
                return SizedBox(
                  width: double.infinity, // يجعل العنصر يملأ عرض الشاشة
                  height: 250.h,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.network(fixedUrl, fit: BoxFit.cover),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
