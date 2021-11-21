import 'package:flutter/material.dart';
import 'package:uplant/modules/guides/guides_view.dart';
import 'package:get/get.dart';
import 'package:uplant/services/auth_service.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              child: const Text(
                'LOGIN',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              onPressed: () {
                AuthService.to.login();
                Get.off(() => GuidesView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
