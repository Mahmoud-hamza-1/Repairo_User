import 'package:bloc/bloc.dart';
import 'package:repairo_app_new/business_logic/SubCategoryCubit/subcategory_states.dart';
import 'package:repairo_app_new/data/models/subcategory_model.dart';
import 'package:repairo_app_new/data/repository/subcategory_repository.dart';

class SubcategoryCubit extends Cubit<SubcategoryStates> {
  SubcategoryCubit(this.subcategoryRepository) : super(SubcategoriesInitial());

  final SubcategoryRepository subcategoryRepository;
  late List<RSubCategoryData> subcategories = [];

  Future<List<RSubCategoryData>> getSubCategories(String id) async {
    subcategoryRepository.getSubCAtegories(id).then((thesubcategories) {
      emit(SubcategoriesLoaded(subcategories: subcategories));
      subcategories = thesubcategories;
    });
    return subcategories;
  }
}
