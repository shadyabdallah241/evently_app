import 'package:easy_localization/easy_localization.dart';
import 'package:evently/util/app_images_path.dart';

class IntroModel {
  String introImage;
  String introTitleSource;
  String introContentSource;

  IntroModel.name({
    required this.introImage,
    required this.introTitleSource,
    required this.introContentSource,
  });

  String get introTitle => introTitleSource.tr();

  String get introContent => introContentSource.tr();
}

List<IntroModel> intros = [
  IntroModel.name(
    introImage: AppImagesPath.intro2,
    introTitleSource: "screen2_title",
    introContentSource: "screen2_description",
  ),
  IntroModel.name(
    introImage: AppImagesPath.intro3,
    introTitleSource: "screen3_title",
    introContentSource: "screen3_description",
  ),
  IntroModel.name(
    introImage: AppImagesPath.intro4,
    introTitleSource: "screen4_title",
    introContentSource: "screen4_description",
  ),
];
