
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:repairo_app_new/business_logic/SubCategoryCubit/subcategory_cubit.dart';
import 'package:repairo_app_new/data/models/category_model.dart';
import 'package:repairo_app_new/data/repository/subcategory_repository.dart';
import 'package:repairo_app_new/data/web_services/subcategories_webservice.dart';
import 'package:repairo_app_new/presentation/screens/subcategories.dart';

class ItemWidget extends StatelessWidget {
  final RCategoryData item;
  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => BlocProvider(
            create: (context) => SubcategoryCubit(SubcategoryRepository(
                subcategoriesWebservice: SubcategoriesWebservice())),
            child: Subcategories(
              id: item.id.toString(),
              catname: item.displayName.toString(),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 98,
            height: 75,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 226, 222, 222),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            child: Transform.scale(
              scale: 0.6,
              child: SvgPicture.asset(
                'assets/images/svg/home.svg',

                // fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 98,
            height: 34,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child: Center(
                child: Text(
              '${item.displayName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
          )
        ],
      ),
    );
  }
}
