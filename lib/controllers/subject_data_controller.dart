import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../models/subject_data_model.dart';

class AppDataController extends GetxController {
  List<SubjectModel> subjectData = [];
  List<MultiSelectItem> dropDownData = [];

  getSubjectData() {
    subjectData.clear();
    dropDownData.clear();

    Map<String, dynamic> apiResponse = {
      "code": 200,
      "message": "Course subject lists.",
      "data": [
        {"subject_id": "1", "subject_name": "English"},
        {"subject_id": "2", "subject_name": "Physics"},
        {"subject_id": "3", "subject_name": "Chemistry"},
        {"subject_id": "4", "subject_name": "Geography"},
        {"subject_id": "5", "subject_name": "Math"},
        {"subject_id": "6", "subject_name": "History"},
        {"subject_id": "7", "subject_name": "Computer Science"},
        {"subject_id": "8", "subject_name": "Arts"}
      ]
    };

    if (apiResponse['code'] == 200) {
      List<SubjectModel> tempSubjectData = [];
      apiResponse['data'].forEach(
            (data) {
          tempSubjectData.add(
            SubjectModel(
              subjectId: data['subject_id'],
              subjectName: data['subject_name'],
            ),
          );
        },
      );
      if (kDebugMode) {
        print(tempSubjectData);
      }
      subjectData.addAll(tempSubjectData);

      dropDownData = subjectData.map((subjectData) {
        return MultiSelectItem(subjectData, subjectData.subjectName);
      }).toList();

      update();
    } else if (apiResponse['code'] == 400) {
      if (kDebugMode) {
        print("Show Error model why error occurred..");
      }
    } else {
      if (kDebugMode) {
        print("show some error model like something went wrong..");
      }
    }
  }
}
