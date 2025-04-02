import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:highway_weight/models/general_lists_model.dart';
import 'package:highway_weight/models/stations_model.dart';
import 'package:image_picker/image_picker.dart';

class GeneralListsController extends ChangeNotifier {
  String generalName = '';
  String description = '';
  int? category;
  LatLng? station;
  Uint8List? image;
  Map<String, String> errorMessage = {};

  List<GeneralListsModel> generalReportLists = [
    GeneralListsModel(
      id: 1,
      name: 'ร้องเรียนรถบรรทุกใกล้วัดพระแก้ว',
      category: IssueCategory.overWeight,
      createdAt: DateTime(
        2025,
        3,
        20,
        14,
        35,
      ), // Added hour (14) and minute (35)
      status: StatusType.pending,
      description: 'มีการขนถ่ายเกินน้ำหนักบริเวณใกล้วัดพระแก้ว',
      station: StationsModel(
        name: 'Grand Palace, Bangkok',
        latLng: LatLng(13.7500, 100.4913),
      ),
    ),
    GeneralListsModel(
      id: 2,
      name: 'แจ้งเจ้าหน้าที่ใช้อำนาจไม่เหมาะสม',
      category: IssueCategory.improperStaff,
      createdAt: DateTime(2025, 3, 18, 9, 15), // Added hour (9) and minute (15)
      status: StatusType.approved,
      description: 'มีเจ้าหน้าที่พูดจาไม่เหมาะสมใกล้สถานีวัดอรุณ',
      station: StationsModel(
        name: 'Wat Arun, Bangkok',
        latLng: LatLng(13.7436, 100.4889),
      ),
    ),
    GeneralListsModel(
      id: 3,
      name: 'รถบรรทุกน้ำหนักเกินเข้าพื้นที่เมืองเก่า',
      category: IssueCategory.overWeight,
      createdAt: DateTime(
        2025,
        3,
        15,
        16,
        45,
      ), // Added hour (16) and minute (45)
      status: StatusType.rejected,
      description: 'พบรถบรรทุกน้ำหนักเกินวิ่งผ่านเขตเมืองเก่าเชียงใหม่',
      station: StationsModel(
        name: 'Chiang Mai Old City',
        latLng: LatLng(18.7883, 98.9853),
      ),
    ),
    GeneralListsModel(
      id: 4,
      name: 'พนักงานตรวจสอบแสดงท่าทีไม่เหมาะสม',
      category: IssueCategory.improperStaff,
      createdAt: DateTime(
        2025,
        3,
        12,
        11,
        20,
      ), // Added hour (11) and minute (20)
      status: StatusType.pending,
      description: 'มีเจ้าหน้าที่ปฏิบัติงานไม่เหมาะสมที่ป่าตอง',
      station: StationsModel(
        name: 'Phuket Patong Beach',
        latLng: LatLng(7.8966, 98.2956),
      ),
    ),
    GeneralListsModel(
      id: 5,
      name: 'รถบรรทุกทำลายทางโบราณ',
      category: IssueCategory.overWeight,
      createdAt: DateTime(2025, 3, 10, 8, 30), // Added hour (8) and minute (30)
      status: StatusType.approved,
      description: 'มีการวิ่งรถบรรทุกขนาดใหญ่บริเวณอุทยานประวัติศาสตร์อยุธยา',
      station: StationsModel(
        name: 'Ayutthaya Historical Park',
        latLng: LatLng(14.3559, 100.5660),
      ),
    ),
    GeneralListsModel(
      id: 6,
      name: 'เจ้าหน้าที่เรียกรับผลประโยชน์',
      category: IssueCategory.improperStaff,
      createdAt: DateTime(
        2025,
        3,
        8,
        13,
        10,
      ), // Added hour (13) and minute (10)
      status: StatusType.pending,
      description: 'ร้องเรียนเจ้าหน้าที่ที่ศาลพระพรหมเอราวัณ',
      station: StationsModel(
        name: 'Erawan Shrine, Bangkok',
        latLng: LatLng(13.7453, 100.5396),
      ),
    ),
    GeneralListsModel(
      id: 7,
      name: 'พบรถน้ำหนักเกินเข้าไร่เลย์โดยไม่ได้รับอนุญาต',
      category: IssueCategory.overWeight,
      createdAt: DateTime(
        2025,
        3,
        6,
        15,
        25,
      ), // Added hour (15) and minute (25)
      status: StatusType.approved,
      description: 'รถบรรทุกใหญ่เข้าเขตไร่เลย์กระบี่',
      station: StationsModel(
        name: 'Railay Beach, Krabi',
        latLng: LatLng(8.0117, 98.8373),
      ),
    ),
    GeneralListsModel(
      id: 8,
      name: 'พฤติกรรมไม่เหมาะสมของเจ้าหน้าที่บนดอยอินทนนท์',
      category: IssueCategory.improperStaff,
      createdAt: DateTime(
        2025,
        3,
        3,
        10,
        05,
      ), // Added hour (10) and minute (05)
      status: StatusType.rejected,
      description: 'พบเจ้าหน้าที่ใช้น้ำเสียงรุนแรงกับนักท่องเที่ยว',
      station: StationsModel(
        name: 'Doi Inthanon, Chiang Mai',
        latLng: LatLng(18.5883, 98.4878),
      ),
    ),
    GeneralListsModel(
      id: 9,
      name: 'รถบรรทุกทำลายโบราณสถานสุโขทัย',
      category: IssueCategory.overWeight,
      createdAt: DateTime(
        2025,
        3,
        1,
        17,
        40,
      ), // Added hour (17) and minute (40)
      status: StatusType.approved,
      description: 'การเข้าออกของรถขนาดใหญ่กระทบต่อโบราณสถาน',
      station: StationsModel(
        name: 'Sukhothai Historical Park',
        latLng: LatLng(17.0154, 99.8200),
      ),
    ),
    GeneralListsModel(
      id: 10,
      name: 'ร้องเรียนเจ้าหน้าที่ที่ด่านเขาใหญ่',
      category: IssueCategory.improperStaff,
      createdAt: DateTime(
        2025,
        2,
        28,
        12,
        50,
      ), // Added hour (12) and minute (50)
      status: StatusType.pending,
      description: 'เจ้าหน้าที่ทำการตรวจไม่เป็นธรรมที่ด่านเข้าอุทยาน',
      station: StationsModel(
        name: 'Khao Yai National Park',
        latLng: LatLng(14.4378, 101.3722),
      ),
    ),
  ];

  void updateField(String field, dynamic value) {
    if (field == 'generalName') {
      generalName = value;
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
    if (field == 'image') {
      image = value;
    }
    print("name: $generalName");
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
        updateField('image', imageBytes);
        print("Image: $image");
      }
    } else {
      print("No Image at all");
    }
  }

  void clearImage() {
    image = null;
    notifyListeners();
  }

  void onPageChanged(int newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  int currentPage = 0;
  int itemsPerPage = 5;
  List<GeneralListsModel> getPaginatedGeneralLists() {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return generalReportLists.sublist(
      startIndex,
      endIndex.clamp(0, generalReportLists.length),
    );
  }
}
