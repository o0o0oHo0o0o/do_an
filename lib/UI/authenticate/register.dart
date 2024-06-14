import 'package:weather/UI/authenticate/authenticate.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/shared/my_validator.dart';
import 'package:weather/UI/authenticate/sign_in.dart';
import 'package:weather/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controller/global_controller.dart';
import '../../provider/loading_provider.dart';
import '../../shared/my_style.dart';
import '../../widgets/loading.dart';
import '../wrapper.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  //controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reenterController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    final loadingProvider = Provider.of<LoadingProvider>(context);
    return Consumer<LoadingProvider>(
      builder: (BuildContext context, loadingProvider, _)  => loadingProvider.isLoading? Loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: myConstants.primaryColor.withOpacity(.8),
          elevation: 0, // Tăng độ nổi của AppBar
          title: Text(
            'Register',
            style: TextStyle(
              color: myConstants.textColor, // Màu chữ của tiêu đề
            ),
          ),
          actions: [
            IconButton(
              icon: Row(
                children: [
                  Icon(Icons.person_2_outlined),
                  Text("Sign in"),
                ],
              ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper(isRegister: false)));
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  myConstants.primaryColor.withOpacity(.8) ?? Colors.pink,
                  myConstants.secondaryColor.withOpacity(.6) ?? Colors.pink
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Image.asset('assets/register.png'),
                        SizedBox(height: 40),
                        buildTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          icon: Icon(Icons.email, color: myConstants.iconColor,),
                          obscureText: false,
                          validator: Validator.validateEmail,
                        ),
                        SizedBox(height: 20),
                        Obx(()=>buildTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          icon: Icon(Icons.security_rounded, color: myConstants.iconColor),
                          suf_icon: IconButton(
                            onPressed: (){
                              globalController.isPasswordVisibility.value = !globalController.isPasswordVisibility.value;
                            },
                            icon: Icon(globalController.isPasswordVisibility.value ? Icons.visibility : Icons.visibility_off)),
                          obscureText: globalController.isPasswordVisibility.value,
                          validator: Validator.validatePassword,
                        ),),
                        SizedBox(height: 20,),
                        Obx(()=>buildTextFormField(
                          controller: _reenterController,
                          labelText: 'Verify password',
                          hintText: 'Re-enter the password',
                          icon: Icon(Icons.security_update, color: myConstants.iconColor),
                          suf_icon: IconButton(
                              onPressed: (){
                                globalController.isRePasswordVisibility.value = !globalController.isRePasswordVisibility.value;
                              },
                              icon: Icon(globalController.isRePasswordVisibility.value ? Icons.visibility : Icons.visibility_off)),
                          obscureText: globalController.isRePasswordVisibility.value,
                          validator: (value) {
                            return Validator.validateRePassword(value, _passwordController.text);
                          },
                        ),),
                        SizedBox(height: 20,),
                        buildElevation(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                loadingProvider.setLoading(true);
                                // Tiến hành đăng ký
                                dynamic res = await _auth.registerWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                if (res == null) {
                                  loadingProvider.setLoading(false);
                                  final snackBar = buildSnackBar(
                                    context: context,
                                    content: 'Register failed! Please try again.',
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                } 
                              }
                            },
                            content: 'Register'
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
