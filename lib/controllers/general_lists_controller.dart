import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:highway_weight/models/general_lists_model.dart';
import 'package:highway_weight/repositories/general_report_repository.dart';
import 'package:image_picker/image_picker.dart';

class GeneralReportsController extends ChangeNotifier {
  final GeneralReportRepository _repository = GeneralReportRepository();
  bool isLoading = false;
  String generalName = '';
  String description = '';
  String comment = '';
  int? category;
  int? station;
  Uint8List? image;
  String? imageFileName;
  int? reportId;
  Map<String, String> errorMessage = {};

  List<GeneralReportsModel> generalReportLists = [];

  Future<void> fetchGeneralReports() async {
    isLoading = true;
    notifyListeners();
    try {
      generalReportLists = await _repository.getAll();
    } catch (e) {
      isLoading = false;
      throw Exception("Fail to fetch get $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createGeneralReports() async {
    isLoading = true;
    notifyListeners();
    try {
      if (generalName != '' &&
          description != '' &&
          category != null &&
          station != null &&
          image != null) {
        final newGeneralReport = await _repository.create(
          generalName,
          description,
          category!.toString(),
          station!.toString(),
          image!,
          imageFileName!,
        );
        generalReportLists.add(newGeneralReport);
      }
      await fetchGeneralReports();
    } catch (e) {
      isLoading = false;
      throw Exception("Fail to fetch create $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deactivateGeneralReport(int reportId) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await _repository.deactivate(reportId);
      final index = generalReportLists.indexWhere(
        (item) => item.id == reportId,
      );
      if (index != -1) {
        generalReportLists[index] = result;
      }
      await fetchGeneralReports();
    } catch (e) {
      isLoading = false;
      throw Exception("Fail to fetch create $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateGeneralReport(int reportId) async {
    isLoading = true;
    notifyListeners();
    try {
      if (generalName != '' &&
          description != '' &&
          category != null &&
          station != null &&
          image != null &&
          imageFileName != null) {
        final result = await _repository.update(
          reportId,
          generalName,
          description,
          category.toString(),
          station.toString(),
          image,
          imageFileName,
        );
        final index = generalReportLists.indexWhere(
          (item) => item.id == reportId,
        );
        if (index != -1) {
          generalReportLists[index] = result;
        }
        await fetchGeneralReports();
      }
    } catch (e) {
      isLoading = false;
      throw Exception("Fail to fetch create $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateField(String field, dynamic value) {
    if (field == 'generalName') {
      generalName = value;
    }
    if (field == 'imageFileName') {
      imageFileName = value;
    }
    if (field == 'description') {
      description = value;
    }
    if (field == 'category') {
      category = value;
    }
    if (field == 'station') {
      station = value;
    }
    if (field == 'comment') {
      comment = value;
    }
    if (field == 'image') {
      image = value;
    }
    notifyListeners();
  }

  Future<Uint8List> _loadImageFromImageNetwork() async {
    final response = await http.get(Uri.parse(imageFileName!));
    return response.bodyBytes;
  }

  Future<void> loadImageFileName() async {
    isLoading = true;
    notifyListeners();
    try {
      image = await _loadImageFromImageNetwork();
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Fail to load image $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateAllField(GeneralReportsModel model) {
    generalName = model.name;
    imageFileName = model.imageUrl;
    description = model.description;
    category = model.category;
    station = model.station.id;
    reportId = model.id;
    notifyListeners();
  }

  void resetAllField() {
    generalName = '';
    imageFileName = null;
    description = '';
    comment = '';
    category = null;
    station = null;
    reportId = null;
    notifyListeners();
  }

  String? validateField(String field, dynamic value) {
    if (field == 'generalName') {
      if (value == '') {
        return "Please type issue name.";
      }
    }
    if (field == 'description') {
      if (value == '') {
        return "Please type the issue description.";
      }
    }
    if (field == 'category') {
      if (value == null) {
        return "Please choose the issue category.";
      }
    }
    if (field == 'station') {
      if (value == null) {
        return "Please choose a station.";
      }
    }
    if (field == 'comment') {
      if (value == '') {
        return "Please fill your comment ";
      }
    }
    return null;
  }

  void validateImage() {
    Map<String, String> error = Map.from(errorMessage);
    if (image == null) {
      error['image'] = "Please attach an image for evidence";
    } else {
      error.remove('image');
    }
    errorMessage = error;
    notifyListeners();
  }

  Future<void> getImageGallery() async {
    final XFile? pickFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickFile != null) {
      if (kIsWeb) {
        Uint8List imageBytes = await pickFile.readAsBytes();
        String imageName = pickFile.name;
        updateField('image', imageBytes);
        updateField("imageFileName", imageName);
      }
    } else {
      print("No Image at all");
    }
  }

  void clearImage() {
    image = null;
    imageFileName = null;
    notifyListeners();
  }

  void onPageChanged(int newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  int currentPage = 0;
  int itemsPerPage = 5;
  List<GeneralReportsModel> getPaginatedGeneralLists(String? id) {
    if (id != null) {
      List<GeneralReportsModel> activeGeneralLists =
          generalReportLists.where((item) => item.isActive).toList()..sort(
            (a, b) =>
                (b.whoCreated?.id.toString() == id ? 1 : 0) -
                (a.whoCreated?.id.toString() == id ? 1 : 0),
          );
      int startIndex = currentPage * itemsPerPage;
      int endIndex = startIndex + itemsPerPage;
      return activeGeneralLists.sublist(
        startIndex,
        endIndex.clamp(0, activeGeneralLists.length),
      );
    } else {
      List<GeneralReportsModel> activeGeneralLists =
          generalReportLists.where((item) => item.isActive).toList();
      int startIndex = currentPage * itemsPerPage;
      int endIndex = startIndex + itemsPerPage;
      return activeGeneralLists.sublist(
        startIndex,
        endIndex.clamp(0, activeGeneralLists.length),
      );
    }
  }
}
