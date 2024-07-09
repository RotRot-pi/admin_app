import 'package:admin_app/controller/order/archive.dart';
import 'package:admin_app/view/widgets/order/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/order.dart';
import '../../widgets/handeling_data_view.dart';

class ArchiveOrdersScreen extends StatelessWidget {
  const ArchiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArchivingOrderController());
    return GetBuilder<ArchivingOrderController>(
        builder: (controller) => HandelingDataView(
            requestStatus: controller.requestStatus,
            child: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  Order order = controller.data[index];
                  return OrderCard(order: order, controller: controller);
                })));
  }
}
