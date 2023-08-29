import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/pages/base/base_screen.dart';
import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/pages/auth/view/sign_up_screen.dart';
import 'package:quitanda/src/pages/common_widgets/app_name_widget.dart';
import 'package:quitanda/src/pages/pages_routes/app_pages.dart';

import '../../common_widgets/custon_text_field.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>(); //Controller do Form

  //Controlador de campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              //Container Logo
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Nome do app
                    const AppNameWidget(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),

                    //Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                            pause: Duration.zero,
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText('Frutas'),
                              FadeAnimatedText('Verduras'),
                              FadeAnimatedText('Legumes'),
                              FadeAnimatedText('Cereais'),
                            ]),
                      ),
                    )
                  ],
                ),
              ),

              //Container de Formulario
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Digite seu email';
                          }
                          if (!email.isEmail) {
                            return 'Digite um email válido';
                          }
                          return null;
                        },
                      ),
                      //Senha
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Digite sua senha';
                          }
                          if (password.length < 7) {
                            return 'Digite uma senha com pelo menos 7 caracteres';
                          }
                          return null;
                        },
                      ),

                      //Botao de entrar
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.customSwatchColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      // Navigator.of(context).pushReplacement(
                                      //   MaterialPageRoute(builder: (c){
                                      //     return BaseScreen();
                                      //   }),
                                      // );
                                
                                      FocusScope.of(context).unfocus();
                                
                                      if (_formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;
                                        authController.signIn(
                                            email: email, password: password);
                                      }

                                      if (_formKey.currentState!.validate()) {}

                                      //Get.offNamed(PagesRoutes.baseRoute);
                                    },
                              child: authController.isLoading.value
                                  ? CircularProgressIndicator()
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),

                      //Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                                color: CustomColors.customContrastColor),
                          ),
                        ),
                      ),

                      //Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Botão de novo usuário
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              side: BorderSide(
                                  width: 2,
                                  color: CustomColors.customSwatchColor)),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (c){
                            //     return SignUpScreen();
                            //   }),
                            // );

                            Get.toNamed(PagesRoutes.signUpRoutes);
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
