import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weather/models/constants.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());
  Constants myConstants = Constants();
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    super.initState();
    getAddress(globalController.getLattitude().value, globalController.getLongitude().value);
  }

  getAddress(double lat, double lon) async {
    try {
      print("Lấy địa chỉ cho tọa độ: ($lat, $lon)");
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        print("Đối tượng Placemark: $place");
        String? locality = place.locality;
        String? subAdministrativeArea = place.subAdministrativeArea;
        String? administrativeArea = place.administrativeArea;

        print("Tên thành phố (locality): $locality");
        print("Khu vực hành chính (subAdministrativeArea): $subAdministrativeArea");
        print("Khu vực hành chính (administrativeArea): $administrativeArea");

        setState(() {
          city = locality?.isNotEmpty == true ? locality! :
          administrativeArea?.isNotEmpty == true ? administrativeArea! :
          subAdministrativeArea?.isNotEmpty == true ? subAdministrativeArea! : "Không xác định";
        });
      } else {
        print("Không tìm thấy địa chỉ cho tọa độ này.");
        setState(() {
          city = "Not Found";
        });
      }
    } catch (e) {
      print("Lỗi khi lấy địa chỉ: $e");
      setState(() {
        city = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, height: 1.5, color: myConstants.textColor),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 16, color: myConstants.textColor.withOpacity(.8), height: 1),
              ),
            ],
          ),
        )
      ],
    );
  }
}
