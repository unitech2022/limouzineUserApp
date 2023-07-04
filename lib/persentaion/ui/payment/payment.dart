import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moyasar/moyasar.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/domin/entities/trip.dart';
import 'package:taxi/persentaion/ui/external_details_screen/external_trip_detials_screen.dart';
import 'package:taxi/persentaion/ui/external_trip_screen/external_trip_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../../controller/trip_cubit/trip_cubit.dart';
import '../home_screen/tabs_screens/start_trip_screen/start_trip_screen.dart';

class PaymentMethods extends StatefulWidget {
  int? total;
  int? type;
  final int tripId;
  final int status ;
  final int driverId ;
  final String driverUserId;
  PaymentMethods(
      {super.key,
      this.total,
    
      required this.driverUserId,
      this.type = 0, required this.tripId, required this.status, required this.driverId});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  PaymentConfig? paymentConfig;

  @override
  void initState() {
    super.initState();
    paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_83UURo8Mjym2nc7jgxKhJLrVKrzgqNhogC5M4RoY',
      amount: widget.total!, // SAR 257.58
      description: 'order ',
      metadata: {'size': '250g'},
      // applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'ليموزين'),
    );
  }

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          if (widget.type == 0) {

            TripCubit.get(context)
                .paymentTrip(
                  endPoint: ApiConstants.paymentPath,
                    tripId: widget.tripId, payment: 1, context: context)
                .then((value) {
              TripCubit.get(context)
                  .changeStatusTrip(
                      tripId: widget.tripId,
                      status: widget.status + 1,
                      userId: widget.driverUserId)
                  .then((value) {
                pushPage(context: context, page: StartTripScreen());
              });
            });
          } else {
            TripCubit.get(context)
                .paymentTrip(
                  endPoint: ApiConstants.paymentExternalPath,
                    tripId: widget.tripId, payment: 1, context: context).then((value){
                      TripCubit.get(context).addBooking(
                            driverId: widget.driverId,
                           type: 1,
                            externalTripId:widget.tripId,
                            context: context);
                    });
           

          }

          showTopMessage(
              context: context,
              customBar: CustomSnackBar.success(
                  backgroundColor: Colors.green,
                  message: "تمت عملية الدفع بنجاح".tr(),
                  textStyle: TextStyle(
                      fontFamily: "font", fontSize: 16, color: Colors.white)));

          break;
        case PaymentStatus.failed:
          // handle failure.

          break;
        case PaymentStatus.initiated:
          // TODO: Handle this case.
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: SvgPicture.asset(
                  "assets/icons/login.svg",
                  width: 80,
                  height: 80,
                ),
              ),
              Texts(
                  title: Strings.onTheWay.tr(),
                  textColor: homeColor,
                  fontSize: 28,
                  align: TextAlign.center,
                  weight: FontWeight.bold),
              SizedBox(
                height: 30,
              ),

              // ApplePay(
              //   config: paymentConfig,
              //   onPaymentResult: onPaymentResult,
              // ),
              // const Text("or"),
              CreditCard(
                config: paymentConfig!,
                onPaymentResult: onPaymentResult,
              )
            ],
          ),
        ),
      ),
    );
  }
}
