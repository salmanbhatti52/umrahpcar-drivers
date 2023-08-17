import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_driver/models/update_driver_location_model.dart';

import '../models/forgot_password_otp_model.dart';
import '../models/forgot_verify_otp_model.dart';
import '../models/get_booking_list_model.dart';
import '../models/get_chat_model.dart';
import '../models/get_driver_profile.dart';
import '../models/login_model.dart';
import '../models/send_message_model.dart';
import '../models/sign_up_model.dart';
import '../models/update_profile_model.dart';
import '../utils/const.dart';



class DioClient {
  final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final _sharedPref = await SharedPreferences.getInstance();
        if (_sharedPref.containsKey('userId')) {
          options.headers["Authorization"] =
          "Bearer ${_sharedPref.getString('userId')}";
        }
        return handler.next(options);
      }),
    );

  Future<LoginModel> login(Map<String,dynamic> model,BuildContext context) async {
    print("mapData: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/login_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= LoginModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email or Password is incorrect")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone Number is incorrect")));

      rethrow;
    }
  }
  Future<SignUpModel> signUp(Map<String,dynamic> model,BuildContext context) async {
    print("mapData: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/signup_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= SignUpModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email already exist")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email already exist")));

      rethrow;
    }
  }
  Future<GetDriverProfile> getProfile(String? uid,BuildContext context) async {
    print("mapData: ${uid}");
    String url= "$baseUrl/get_details_drivers/$uid";
    print("url: ${url}");

    try {
      final response =
      await _dio.post(url);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetDriverProfile.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Data Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Data Found")));

      rethrow;
    }
  }


  Future<ForgotOtpVerifyModel> changeUserPassword(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/change_user_password_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Old password is wrong")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<UpdateProfileModel> updateProfile(Map<String,dynamic> model,BuildContext context) async {

    try {
      final response =
      await _dio.post('$baseUrl/update_profile_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= UpdateProfileModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All Fields are needed")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }Future<UpdateDriverLocationModel> updateDriverLocation(Map<String,dynamic> model,BuildContext context) async {

    try {
      final response =
      await _dio.post('$baseUrl/update_locations_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= UpdateDriverLocationModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All Fields are needed")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<GetBookingListModel> getBookingupcoming(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_drivers_upcoming', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<GetBookingListModel> getBookingOngoing(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_drivers_ongoing', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<GetBookingListModel> getBookingCompleted(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_drivers_completed', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<GetChatModel> getChat(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_messages', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetChatModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }


  Future<SendMessageModel> sendMessage(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/send_messages', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= SendMessageModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }





  Future<ForgotPasswordOtpModel> forgotPasswordOtp(Map<String,dynamic> model,BuildContext context) async {

    try {
      final response =
      await _dio.post('$baseUrl/reset_password_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= ForgotPasswordOtpModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email does not exists.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<ForgotOtpVerifyModel> verifyForgotPasswordOtp(Map<String,dynamic> model,BuildContext context) async {

    try {
      final response =
      await _dio.post('$baseUrl/verify_otp_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP is incorrect.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<ForgotOtpVerifyModel> resetNewPassword(Map<String,dynamic> model,BuildContext context) async {
print("model: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/reset_password_set_drivers', data: model);
      print("code status: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP is incorrect.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }







}
