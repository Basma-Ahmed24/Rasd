import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/utils/constants.dart';
import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import '../../Admin_side/home/home_screen.dart';
import '../nav_bar/navigation_bar.dart';
import '../sign_up/sign_up_screen.dart';
import 'bloc/User.dart';
import 'bloc/cubit.dart';

class SignIn extends StatefulWidget{
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  String? name, phone, password, confirmPass, nationalId;
  var formkey = GlobalKey<FormState>();
  bool showPassword = true;

  var passwordcontroller = TextEditingController();
  var firstnamecontroller = TextEditingController();

  Widget build(BuildContext context) {
    // TODO: implement build
    return  BlocProvider(
        create: (context) => SignInCubit(),
        child: BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state.isSuccess) {
                if(state.signinModel?.googleId=="29001040202477"&&state.signinModel?.passHash=="2540")
                  navigateto(context,AdminHome());
else
                navigateto(context,MyNavigationBar());
                // that should occur after a successful sign-up
              } else if (state.errorMessage!=null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );}
            },
            builder: (context, state) {
      return Scaffold(
        backgroundColor: Primary,
        body: Padding(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 15,
                    ),
                    Center(
                      child: Text(
                        "${AppLocalizations.of(context)?.translate("Sign_In")}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: green,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 13,
                    ),
                    Container(
                        height: 53,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: textFormField(
                            hintText: "${AppLocalizations.of(context)?.translate("id")}", icon: Constants
                            .person1, show: false)),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 23,
                    ),

                    Container(
                        height: 53,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: textFormField(
                            hintText: "${AppLocalizations.of(context)?.translate("pass")}",
                            icon: Constants.pass,
                            lock: Constants.unlock,
                            unlock: Constants.lock,
                            show: true)),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 30,
                    ),
                    SingleChildScrollView(scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        SizedBox(width: MediaQuery
                            .of(context)
                            .size
                            .width / 3,),
                        Text("${AppLocalizations.of(context)?.translate("fprget")} ", style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.grey),)
                      ]),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 8,
                    ),


                    ElevatedButton(
                      onPressed: state.isLoading ? null : () {
                          _onSignInPressed(context);},
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: green,)
                          :  Text(
                        "${AppLocalizations.of(context)?.translate("enter")}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat"),
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: const Size(138, 49),
                        backgroundColor: green,
                      ),

                    ),

                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                    ),
                    InkWell(onTap: () => navigateto(context, SignUp()),
                      child: Center(child: Text(
                        "${AppLocalizations.of(context)?.translate("dont")}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily:
                        "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff252525)),),),
                    )
                  ],
                ),
              )),
        ),
      );
    }));}
  void _onSignInPressed(BuildContext context) {
    if (formkey.currentState!.validate()) {



        final signinModel = User(
          googleId: firstnamecontroller.text,

          passHash: passwordcontroller.text,

        );

        CacheHelper.savedata(key: "apiToken", value: firstnamecontroller.text,);
        context.read<SignInCubit>().signIn(signinModel);

    }
  }

  Widget textFormField({
    required String? hintText,
    required bool show,
    IconData? icon,
    IconData? lock,
    IconData? unlock,
  }) {
    final TextEditingController controller =
    hintText == "${AppLocalizations.of(context)?.translate("pass")}" ? passwordcontroller : firstnamecontroller;

    return TextFormField(
      keyboardType: hintText!.trim() == "${AppLocalizations.of(context)?.translate("id")}" ||
          hintText.trim() == "${AppLocalizations.of(context)?.translate("phone")}"
          ? TextInputType.phone
          : TextInputType.name,
      controller: controller,
      onSaved: (newValue) {
        if (hintText.trim() == "${AppLocalizations.of(context)?.translate("id")}") {
          name = newValue!;
          firstnamecontroller.text=newValue;
        } else if (hintText.trim() == "${AppLocalizations.of(context)?.translate("pass")}") {
          password = newValue!;
          passwordcontroller.text = newValue;
        }
      },
      validator: (value) {
        if (hintText.trim() == "National ID".trim()) {
          if (value!.isEmpty) {
            return "This Field Must not be empty ";
          }
        }

        if (hintText.trim() == Constants.password.trim()) {
          if (value!.isEmpty) {
            return "password address must not be empty";
          }
          if (value.length < 4 || value.length > 4) {
            return "your password must be 4 numbers ";
          }
        }

        return null;
      },
      obscureText: show,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: "Montserrat"),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
            width: 50,
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black54,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hintText,
        suffixIcon: InkWell(
          onTap: () {},
          child: Icon(
            lock,
            color: Colors.black26,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
      ),
      style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: "Montserrat"),
    );
  }
}