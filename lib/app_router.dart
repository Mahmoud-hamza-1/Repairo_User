
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairo_app_new/business_logic/AllCategoriesCubit/allcaterories_cubit.dart';
import 'package:repairo_app_new/business_logic/AllTechniciansCubiit/alltechnisian_cubit.dart';
import 'package:repairo_app_new/business_logic/CategoriesTreeCubit/categories_tree_cubit.dart';
import 'package:repairo_app_new/business_logic/HomeCubit/home_cubit.dart';
import 'package:repairo_app_new/business_logic/LoginCubit/login_cubit.dart';
import 'package:repairo_app_new/data/repository/categories_repository.dart';
import 'package:repairo_app_new/data/repository/categories_tree_repository.dart';
import 'package:repairo_app_new/data/repository/home_repository.dart';
import 'package:repairo_app_new/data/repository/login_repository.dart';
import 'package:repairo_app_new/data/repository/technicians_repository.dart';
import 'package:repairo_app_new/data/web_services/categories_tree_webservices.dart';
import 'package:repairo_app_new/data/web_services/categories_webservices.dart';
import 'package:repairo_app_new/data/web_services/home_webservices.dart';
import 'package:repairo_app_new/data/web_services/login_webservice.dart';
import 'package:repairo_app_new/data/web_services/technicians_webservices.dart';
import 'package:repairo_app_new/presentation/screens/allcategories.dart';
import 'package:repairo_app_new/presentation/screens/home_screen.dart';
import 'package:repairo_app_new/presentation/screens/login_screen.dart';
import 'package:repairo_app_new/presentation/screens/main_screen.dart';
import 'package:repairo_app_new/presentation/screens/providers.dart';
import 'package:repairo_app_new/presentation/screens/search.dart';

class AppRouter {
  late CategoriesRepository categoriesRepository;
  late AllcategoriesCubit allcategoriesCubit;

  AppRouter() {
    categoriesRepository =
        CategoriesRepository(categoriesWebservices: CategoriesWebservices());
    allcategoriesCubit = AllcategoriesCubit(categoriesRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case 'editprofile':
      //   return MaterialPageRoute(builder: (_) => EditProfileScreen());

      // case 'map':
      //   return MaterialPageRoute(builder: (_) => MapScreen());

      case 'providers':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AllcategoriesCubit>(
                create: (context) => allcategoriesCubit,
              ),
              BlocProvider<AlltechnisianCubit>(
                create: (context) => AlltechnisianCubit(TechniciansRepository(
                    techniciansWebservices: TechniciansWebservices())),
              ),
            ],
            // create: (_) => AlltechnisianCubit(TechniciansRepository(
            //     techniciansWebservices: TechniciansWebservices())),
            child: FilterScreen(),
          ),
        );

      case 'mainscreen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AllcategoriesCubit>(
                create: (context) => allcategoriesCubit,
              ),
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(
                    HomeRepository(homeWebservices: HomeWebservices()))
                  ..getBannerImages(''),
              ),
              BlocProvider<CategoriesTreeCubit>(
                create: (context) => CategoriesTreeCubit(
                    CategoriesTreeRepository(
                        categoriesTreeWebservices: CategoriesTreeWebservices()))
                  ..getCategoriesTree(),
              ),
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(
                    HomeRepository(homeWebservices: HomeWebservices()))
                  ..getBannerImages(''),
              ),
            ],
            child: MainScreen(),
          ),
        );

      case 'search':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                HomeCubit(HomeRepository(homeWebservices: HomeWebservices())),
            child: const SearchScreen(),
          ),
        );

      case 'login':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(AuthRepository(AuthWebService())),
            child: const LoginScreen(),
          ),
        );

      // case 'servproviders':
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (_) =>
      //           HomeCubit(HomeRepository(homeWebservices: HomeWebservices())),
      //       child: const FilteredTechniciansScreen(),
      //     ),
      //   );

      case 'allcategories':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AllcategoriesCubit(CategoriesRepository(
                categoriesWebservices: CategoriesWebservices())),
            child: const Allcategories(),
          ),
        );

      case 'home':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AllcategoriesCubit>(
                create: (context) => allcategoriesCubit..getAllCategories(),
              ),
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(
                    HomeRepository(homeWebservices: HomeWebservices()))
                  ..getBannerImages(''),
              ),
            ],
            child: const HomeScreen(),
          ),
        );

      // case 'profile':
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) =>
      //                 ProfileCubit(ProfileRepository(ProfileWebservices()))
      //                   ..getUserData(''),
      //             child: ProfileScreen(),
      //           ));

      // case 'verification':
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) => VerificationCubit(
      //                 VerificationRepository(VerificationWebservices())),
      //             child: Verification(),
      //           ));
    }
    return null;
  }
}
