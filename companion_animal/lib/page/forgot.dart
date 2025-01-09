import 'package:flutter/material.dart';
import 'package:companion_animal/widget/custom_text_field.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  late TextEditingController _emailController;
  bool _showFAB = false;
  final _formKey = GlobalKey<FormState>();

  void _verifyEmail() {
  }

  void _checkEmail() {
    setState(() {
          _showFAB = _emailController.text.contains("@");
    });

  }

  void _sendResetMail() {
    print("New Password Sent : l15978!");
    _emailController.text = "";
  }

  @override void initState() {
    _emailController = TextEditingController();
    _emailController.addListener(_checkEmail);
    super.initState();
  }

  @override void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("비밀번호재설정"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Spacer(),
        const Text("이메일 주소 입력"),
        const SizedBox(height: 10,),
        const Text("해당 이메일주소로 비밀번호 재설정할수있는 메일을 보내드립니다"),
        const SizedBox(height: 15,),
        Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: "이메일 주소",
                autoFocus: true,
                validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains("@")) {
                            return "이메일을 확인해주세요";
                          }
                          return null;
                        },
              ),
              ),
        ),
          const Spacer(),
          const SizedBox(height: 200,)
      ],
      ), 
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation,child: child);
        },
        child: _showFAB ? FloatingActionButton.extended(onPressed: (){
          if(_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(label: 'Ok', onPressed: () {
                  Navigator.pop(context);
                }
                ),
                content: const Text("비밀번호재설정 링크를 이메일로 보내드렸습니다"),
                duration: const Duration(milliseconds: 1500),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            );
          }
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        label: const Text("보내기"),
        icon: const Icon(Icons.mail_outline),
        ) : Container()
      )

      );
  }
}