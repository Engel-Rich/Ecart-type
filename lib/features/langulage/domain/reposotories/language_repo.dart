import 'package:ecartify/features/langulage/domain/models/language_model.dart';
import 'package:ecartify/util/app_constants.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
