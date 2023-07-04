import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/data/models/wallet.dart';
import 'package:taxi/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';

import '../../../core/widgets/icon_back_button.dart';

import '../home_screen/components/drawer_widget.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCubit.get(context).getWallets();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("محفظتي".tr()),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white)),
        ],
        leading: IconBackButton(),
      ),
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        return state.getWalletsState == RequestState.loading
            ? Center(child: LoadingWidget(height: 50, color: homeColor))
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$${state.walletResponse!.user.points}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: homeColor,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemCount: state.walletResponse!.wallets.length,
                        itemBuilder: (ctx, index) {
                          Wallet wallet = state.walletResponse!.wallets[index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 60,
                            child: Center(
                              child: Row(
                                children: [
                                  Text("#${wallet.id}"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Text(
                                    wallet.desc!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      
                                    children: [
                                      Text(
                                        "SAR  ${wallet.amount.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      Text(wallet.createAt!.split("T")[0],
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                      ))
                    ]),
              );
      }),
    );
  }
}
