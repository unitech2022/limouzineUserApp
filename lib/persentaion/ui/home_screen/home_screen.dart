import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/widgets/texts.dart';
import 'package:taxi/persentaion/controller/home_cubit/cubit/home_cubit.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/offers_trip_screen/offers_trip_screen.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/running_trip_screen/running_trip_screen.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/start_trip_screen/start_trip_screen.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/trip_summary_screen/trip_summery_screen.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utlis/strings.dart';
import 'components/app_bar_home.dart';
import 'components/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> screens = [
    const StartTripScreen(),
    const TripSummeryScreen(),
    const OffersTripScreen(),
     const RunningTripScreen()
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            endDrawer: DrawerWidget(
              scaffoldKey: _scaffoldKey,
            ),
            body: Stack(children: [
              IndexedStack(
                index: state.currentIndex,
                children: screens,
              ),
              Positioned(
                top: 53,
                left: 24,
                right: 24,
                child: AppBarHome(
                  onTap: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                    
                  },
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
