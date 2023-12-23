import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:texiapptaxi/constant/color.dart';
import 'package:texiapptaxi/controllers/taxi_controllers/taxiorders_controller.dart';
import 'package:texiapptaxi/core/handlingdataview.dart';
import 'package:texiapptaxi/data/models/taxi_orders_model.dart';
import 'package:texiapptaxi/services/services.dart';
import 'package:texiapptaxi/view/pages/taxiDetail/taxidetail.dart';
import 'package:texiapptaxi/view/widget/TaxiWidgets/taxiorder/taxiorder.dart';

class TaxiOrders extends StatelessWidget {
  const TaxiOrders({super.key});

  @override
  Widget build(BuildContext context) {
    
    TextTheme themeText = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: Text(
              "الطلبات",
              style: themeText.titleLarge,
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.015),
                child: Center(
                  // margin: EdgeInsets.only(right: 10),
                  child: Card(
                      elevation: 4,
                      shadowColor: Theme.of(context).colorScheme.shadow,
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: const Icon(
                          Iconsax.refresh,
                          color: AppColor.primary,
                        ),
                      )),
                ),
              )
            ],
          ),
          GetBuilder<TaxiOrdersController>(
            init: TaxiOrdersController(),
            builder: (controller) {
              return HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final taxiOrderModel =
                          TaxiOrderModel.fromJson(controller.data[index]);
                      return TaxiOrder(
                        onTap: () {
                          Get.to(() => TaxiDetailPage(
                                taxiOrderModel: taxiOrderModel,
                              ));
                        },
                        taxiOrderModel: taxiOrderModel,
                      );
                    },
                    childCount: controller.data.length ,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
