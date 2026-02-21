import 'package:flutter/material.dart';
import 'package:flutter_project_model/modules/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../../../global/widget/bottom_button.dart';
import '../../../global/widget/custom_text_form_field.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  final store = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hint: 'Login',
                          controller: store.loginController,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hint: 'Senha',
                          controller: store.passwordController,
                          obscureText: store.obscurePassword,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            icon: Icon(
                              store.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () => store.onChangeObscure(),
                          ),
                        ),
                      ],
                    ),
                  )
                ),

                const Spacer(),
                BottomButton(
                  text: 'Entrar',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    store.login();
                  },
                )
              ],
            ),
          ),
          Obx(() => store.isLoading.value ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ) : Container()
          ),
        ]
      ),
    );
  }
}
