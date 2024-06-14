import 'package:weather/controller/global_controller.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/models/my_user.dart';
import 'package:weather/provider/loading_provider.dart';
import 'package:weather/UI/authenticate/authenticate.dart';
import 'package:weather/shared/my_validator.dart';
import 'package:weather/UI/authenticate/register.dart';
import 'package:weather/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../shared/my_style.dart';
import '../../widgets/loading.dart';
import '../wrapper.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    Constants myConstants = Constants();
    return Consumer<LoadingProvider>(
      builder: (context, loadingProvider, _) => loadingProvider.isLoading ? Loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: myConstants.primaryColor.withOpacity(.8),
          elevation: 0,
          title: Text(
            'Sign in',
            style: TextStyle(
              color: myConstants.textColor, // Màu chữ của tiêu đề
            ),
          ),
          actions: [
            IconButton(
              icon: Row(
                children: [
                  Icon(Icons.person_2_outlined, color: myConstants.iconColor),
                  Text("Register"),
                ],
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper(isRegister: true)));
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
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
                  myConstants.secondaryColor.withOpacity(.7) ?? Colors.pink,
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
                        SizedBox(height: 40),
                        Image.asset('assets/signin.png'),
                        SizedBox(height: 40),
                        buildTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          icon: Icon(Icons.email, color: myConstants.iconColor),
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
                        )),
                        SizedBox(height: 20),
                        buildElevation(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loadingProvider.setLoading(true);
                              dynamic res = await _auth.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                              if (res == null) {
                                loadingProvider.setLoading(false);
                                final snackBar = buildSnackBar(context: context, content: 'Account not found. Please try again');
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                });
                              } else {
                                print('success');
                                loadingProvider.setLoading(false);
                              }
                            }
                          },
                          content: 'Sign in',
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
