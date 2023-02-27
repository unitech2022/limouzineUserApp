import 'package:flutter/material.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/offers_trip_screen/components/row_details_item_offer.dart';

import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/widgets/circle_image_widget.dart';
import '../../../../../../core/widgets/texts.dart';

class ItemOffersList extends StatelessWidget {
  const ItemOffersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 19),
      margin: const EdgeInsets.only(bottom: 8),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const CircleImageWidget(
              height: 52,
              width: 52,
              image: "assets/images/person.png"),
          const SizedBox(
            width: 17,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Texts(
                        title: "رحيم سليم سوريش",
                        textColor: textColor,
                        fontSize: 14,
                        weight: FontWeight.normal,
                        align: TextAlign.start),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                                  6),
                          color: buttonsColor),
                      child: const Texts(
                          title: "١٢٩،٩",
                          textColor: Colors.white,
                          fontSize: 12,
                          weight: FontWeight.normal,
                          align: TextAlign.center)),
                ],
              ),
              const SizedBox(height: 9,),
              Row(
                children:const [
                  RowDetailsItemOffer(icon: "assets/icons/time_trip.svg",value: "١٢ دقيقه",),
                  SizedBox(
                    width: 25,
                  ),
                   RowDetailsItemOffer(icon: "assets/icons/rate_trip.svg",value: "٥/١٠",),
                ],
              )
            ],
          ))
           
           ,Image.asset("assets/images/imag1.png",width: 70,height: 70,fit: BoxFit.contain,)
       
        ],
      ),
    );
  }
}
