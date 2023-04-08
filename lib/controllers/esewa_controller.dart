import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EsewaController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  esewaPay(price) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
            clientId: 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R  ',
            secretId: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
            environment: Environment.test),
        esewaPayment: EsewaPayment(
          productId: '001',
          productName: "Product One",
          productPrice: price.toString(),
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
          // verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }
}
