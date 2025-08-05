import 'dart:io';

import 'package:chat_v2/components/login/login_form.dart';
import 'package:chat_v2/stores/form/login/login_form.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginStore = GetIt.instance<LoginFormStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Observer(
            builder: (context) {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 1500),
                    child: loginStore.isLogin
                        ? SvgPicture.asset(
                            'assets/images/svg/chat-logo.svg',
                            height: MediaQuery.of(context).size.height * 0.35,
                          )
                        : Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: loginStore.formData['imageUrl'] == null
                                    ? SvgPicture.asset(
                                        'assets/images/svg/default-user.svg',
                                      )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(
                                          File(loginStore.formData['imageUrl']),
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    onPressed: () async =>
                                        await loginStore.setImageUrl(),
                                    style: TextButton.styleFrom(
                                      overlayColor: Colors.transparent,
                                    ),
                                    iconSize: 30.0,
                                    icon: Icon(
                                      FontAwesome.camera_alt,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
                child: LoginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
