import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/core/constant/routes.dart';
import 'package:ecommercecourse/core/functions/handingdatacontroller.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/data/datasource/remote/auth/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';


abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          if (response['data']['users_approve'] == "1") {
            myServices.sharedPreferences
                .setString("id", response['data']['users_id']);
            myServices.sharedPreferences
                .setString("username", response['data']['users_name']);
            myServices.sharedPreferences
                .setString("email", response['data']['users_email']);
            myServices.sharedPreferences
                .setString("phone", response['data']['users_phone']);
            myServices.sharedPreferences.setString("step", "2");

            String userid = myServices.sharedPreferences.getString("id")!;
            FirebaseMessaging.instance.subscribeToTopic("users");
            FirebaseMessaging.instance.subscribeToTopic("users${userid}");

            Get.offNamed(AppRoute.homepage);
          } else {
            Get.toNamed(AppRoute.verfiyCodeSignUp,
                arguments: {"email": email.text});
          }
        } else {
          Get.defaultDialog(
              title: "ُWarning", middleText: "Email Or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }
  //-----------------------------------Begin:  New Notifivation  /////////////////
  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "ecommerceroqsal2026",
      "private_key_id": "3fa5488c15891583bf03df267178b8b872570865",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDDBjWKy+iSzI9T\nowcUOLRYrnotx7M554yYwr+Rlvhd+CneI9wdqvHSdRsvspL5xqMlOvgtEf9KGJwz\nknU5Xbg2DaiAH1/950VGFTxLSEWEIwQWtEDjHX+/JHPzYDT34liHjjHql/0c1dRe\nmE5yUoXJBgJhIE/0DzaRy6ShQhwwPEM68I22ruA74u9mHjXkSQ96A/yqnAq7JeQv\ncmLNPXRaWHf7J/THZcAHF247V0/fSWJ5Q7+WH2IvK3xYfB4f10d2pTdCQUwUEdat\nyyq6i1DYHLY5SfKrfggR2GsnZFjCUMxTvPPFaPvkTknd1yjrjrqGJcPWMoz+iiWr\nqpbz+9nxAgMBAAECggEAALSsi+3fT8IFa22QcH52CfNzsL0OGnxf3LZTtXtWNxeB\n+0emRnCLGH0Lq06voSTFYV9HF6P+3a3yHsOoa0aPYe6xuJOkfXQ7+Bwf5ZEuOI4H\nN+0mEPcB3Sy3bgmKl4e4/0tAm1M6e24Qqy5M67VTE55THYvdjjS3OKwufSuSk4rF\nU5hMvUb1R1nedwKKCgMKe+mdEGezRnEEf0htMjITkCRMSEVFWhNiEXv+cvCdIMe1\nmLbNivz7oLiogUGUAuj+D07WIhTvLNikg+04HDo5a60sH7sgxyvQln5QAbRWqqta\nrdHsKM96Lav6vl+bs2fp+PMRNRdmKamsL7p/ZsYaIwKBgQD5zo87pUnHpXm3mYhC\n2XboVAIty7MjZPgZDUo0rutZE/LqclzygKWFD+xUv1zS/NedscV2xpsQbg2moMxm\nJgocRmZEXEBzD3r/z6W6PtLPOWN11A6UYiuAeqnUE/0xeqePz75dzQsuD8OJbWZ2\nS2375rT21iuf7CA2plmwHC/uSwKBgQDH2/Z1PuByvoytZ9YfECGsgXi/jxufCwYZ\n9z4mnFFJokvoq6LwRZkJRp4g7oIPcGHj/CITyQM0Y8x0e7CCYLN5qUBznco9dcOa\ntLIVJqA9XVGp7BDm3lxTFh7CO941H7NLcHSfnQI/AeL+qf0e6TlXr8TTTitaBonC\nVP5d0x2DMwKBgQCIi9cRRF0a6yGoMR0hZVswzVLPk4vc6gEPOIt6Vq7AZz4d1ttl\nltpi7HxDKsLjdV+qjBSiwxbZmT6O+VAg+eQG5phZ/48fFbQnBmrRbiuvJ/Bs5Lf/\nddXPib0w9qgslp3m5yhof37/84/vm8QpHzwEOGxsjE8WQGyvUqitsgqlFwKBgQCy\nfB5+VsjbsJCxzCnNU/q+tGHBsWxZfN7WEZfPo4p02BwyjhXVvlINlqNhhZ9halwB\n3woP4VSbVQUigdQAm5us6xpEJoaWnLUzVGw1t2kjZFOqDMiLZcnN6dNOY2juyIC2\nvpdodC+tVWIDTIxhLqenR7Hfg8/zdiNRCdagtAmHQQKBgCqBUzO4iPU1k/dZaHoO\nmJrIHo4oPrMO4OEiKBy0dUWXDCu5lMgX2ut88UU1CkPfsEvLLo205Rvfiu0jHa5C\neyolem+tXcZhA2cbzra16dTLzsED4A5ZCU68sctJJ1qVoA3hpDn5YR1nwGPOGGm4\nXGpC8ozeF1Qdu22M3A5inFxv\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-wxzz1@ecommerceroqsal2026.iam.gserviceaccount.com",
      "client_id": "113383536465795233264",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-wxzz1%40ecommerceroqsal2026.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
    ;
    /*{
      "type": "",
      "project_id": "",
      "private_key_id": "",
      "private_key":"",
      "client_email": "",
      "client_id": "",
      "auth_uri": "",
      "token_uri": "",
      "auth_provider_x509_cert_url":
          "",
      "client_x509_cert_url":
          "",
      "universe_domain": ""
    };*/

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
      await auth.obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client);

      client.close();
      print(
          "===================Begine: Access Token (Server Id)  ====================");
      print(
          "Access Token: ${credentials.accessToken.data}");
      print(
          "===================End: Access Token (Server Id) ====================");

      /*print(
          "Access Token: ${credentials.accessToken.data}"); */// Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }
  //-----------------------------------End:  New Notifivation  /////////////////

  @override
  void onInit() {

    //-------------------------- Code New for me ------------------------------
    FirebaseMessaging.instance.getToken().then((value) {
      print("\n=========================================================== \ntoken : \n$value");
      print("\n=========================================================== \n");
      String? token = value;
    });
    //getAccessToken()
    getAccessToken();

    //-----------------------------------------------
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}
