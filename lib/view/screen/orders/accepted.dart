import 'package:admin_app/controller/order/accepted.dart';
import 'package:admin_app/view/widgets/order/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/order/pending.dart';
import '../../../../data/model/order.dart';
import '../../widgets/handeling_data_view.dart';

class AcceptedOrdersScreen extends StatelessWidget {
  const AcceptedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AcceptedOrderController());
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Pending"),
        // ),
        body: GetBuilder<AcceptedOrderController>(
            builder: (controller) => HandelingDataView(
                requestStatus: controller.requestStatus,
                child: ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      Order order = controller.data[index];

                      return OrderCard(
                        order: order,
                        controller: controller,
                      );
                    }))));
  }
}
