import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/utlis/api_constatns.dart';
import '../../../../../../core/widgets/texts.dart';
import '../../../../../../domin/entities/car_type.dart';
import '../../../../../controller/app_cubit/cubit/app_cubit.dart';

class ListCarTypes extends StatefulWidget {
  List<CartType> carTypes;
  final Function(int) carTypeId;
  ListCarTypes(this.carTypes, this.carTypeId);

  @override
  State<ListCarTypes> createState() => _ListCarTypesState();
}

class _ListCarTypesState extends State<ListCarTypes> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, stateApp) {
        return ListView.builder(
            itemCount: widget.carTypes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AppCubit.get(context).changeValue(widget.carTypes[index].id);

                  setState(() {});
                  widget.carTypeId(widget.carTypes[index].id);
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: .5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: homeColor, width: 1),
                            shape: BoxShape.circle),
                        child: Container(
                          height: 14,
                          width: 14,
                          margin: EdgeInsets.all(.5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppCubit.get(context).selectedRadio ==
                                      widget.carTypes[index].id
                                  ? homeColor
                                  : Colors.white),
                        ),
                      ),
                      sizedWidth(10),
                      CachedNetworkImage(
                        imageUrl:
                            ApiConstants.imageUrl(widget.carTypes[index].image),
                        height: 40,
                        width: 40,
                      ),
                      sizedWidth(15),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Texts(
                                title: widget.carTypes[index].name,
                                textColor: Colors.black,
                                fontSize: 15,
                                weight: FontWeight.normal,
                                align: TextAlign.start),
                            Texts(
                                title: widget.carTypes[index].sets.toString(),
                                textColor: Colors.black,
                                fontSize: 15,
                                weight: FontWeight.normal,
                                align: TextAlign.start),
                          ],
                        ),
                      ),
                      Texts(
                          title:
                              " ر س " + widget.carTypes[index].price.toString(),
                          textColor: Colors.black,
                          fontSize: 15,
                          weight: FontWeight.bold,
                          align: TextAlign.start),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

