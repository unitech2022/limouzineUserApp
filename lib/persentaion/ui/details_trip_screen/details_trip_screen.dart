import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/utlis/strings.dart';

import 'package:taxi/data/models/history_response.dart';

import '../../../core/helpers/functions.dart';
import '../../../core/utlis/api_constatns.dart';

class DetailsTripScreen extends StatelessWidget {
  final HistoryModel historyModel;
  const DetailsTripScreen({super.key, required this.historyModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ملخص الرحلة".tr()),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "رحلة رقم".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "#" + historyModel.trip!.id.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.amber),
                      ),
                    ],
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: historyModel.trip!.status == 6
                              ? Colors.green
                              : Colors.red),
                      child: Text(
                        historyModel.trip!.status == 6 ? "تمت".tr() : "ملغية".tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ItemContainerTRIP(
                title: "تاريخ الرحلة".tr(),
                value: historyModel.trip!.createdAt.split("T")[0],
              ),
              GestureDetector(
                  onTap: () {
                  openGoogleMapLocation(
                      lat: historyModel.trip!.startPointLat,
                      lng: historyModel.trip!.startPointLng);
                },
                child: ItemContainerTRIP(
                  title: "محطة الذهاب".tr(),
                  value: historyModel.trip!.startAddress,
                ),
              ),
              GestureDetector(
                onTap: () {
                  openGoogleMapLocation(
                      lat: historyModel.trip!.endPointLat,
                      lng: historyModel.trip!.endPointLng);
                },
                child: ItemContainerTRIP(
                  title: "محطة الوصول".tr(),
                  value: historyModel.trip!.endAddress,
                ),
              ),
              ItemContainerTRIP(
                title: "سعر الرحلة".tr(),
                value: historyModel.trip!.price.toString() + " SAR",
              ),
              ItemContainerTRIP(
                title: "طريقة الدفع".tr(),
                value: "كاش".tr(),
              ),
              ItemContainerTRIP(
                title: "نوع السيارة".tr(),
                value: historyModel.carType!.name,
              ),
              ItemContainerTRIP(
                title: "الوقت المتوقع".tr(),
                value: "20 د",
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "بيانات السائق".tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: buttonsColor),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ItemContainerTRIP(
                title: "اسم السائق".tr(),
                value: historyModel.userDetailDiver!.fullName!,
              ),
              ItemContainerTRIP(
                title: "رقم الهاتف".tr(),
                value: historyModel.userDetailDiver!.userName!,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                      width: .5,
                      color: const Color.fromARGB(255, 194, 193, 193)),
                )),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "صورة السيارة".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: .9, color: Colors.grey)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Icon(Icons.person),
                            imageUrl: ApiConstants.imageUrl(
                                historyModel.driver!.carImage),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemContainerTRIP extends StatelessWidget {
  final String title, value;
  const ItemContainerTRIP({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            width: .5, color: const Color.fromARGB(255, 194, 193, 193)),
      )),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
