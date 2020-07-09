/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/


import 'dart:async';
import 'dart:convert';
import 'package:huawei_account/auth/account.dart';
import 'package:huawei_account/auth/auth_huawei_id.dart';
import 'package:huawei_account/helpers/auth_param_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String METHOD_CHANNEL_NAME = "huawei_account";

typedef SmsListener({String message, String errorCode});


class HmsAccount {
  static MethodChannel _channel = init();

  static MethodChannel init () {
    MethodChannel channel = MethodChannel(METHOD_CHANNEL_NAME);
    channel.setMethodCallHandler(_handleSms);
    return channel;
  }

  static SmsListener _listener;


  static Future<dynamic> _handleSms(MethodCall call) {
    if (_listener != null) {
      if (call.method == "timeOut") {
        String errorCode = call.arguments["errorCode"];
        _listener(errorCode:errorCode);
        _listener = null;
      } else if (call.method == "readSms") {
        _listener(message: call.arguments["message"] ?? "empty");
        _listener = null;
      }
    }

    return Future<dynamic>.value(null);
  }

  static Future<AuthHuaweiId> signIn(AuthParamHelper authParamHelper) async {
    AuthHuaweiId authHuaweiId;
    final String response = await _channel.invokeMethod('signIn', authParamHelper.authParamHelpers);
    Map<String, dynamic> signInObj = json.decode(response);
    authHuaweiId = new AuthHuaweiId.fromJson(signInObj);
    return authHuaweiId;
  }

  static Future<AuthHuaweiId> signInWithAuthorizationCode(AuthParamHelper authParamHelper) async {
    AuthHuaweiId authHuaweiId;
    final String result = await _channel.invokeMethod('signInWithAuthorizationCode', authParamHelper.authParamHelpers);
    Map<String, dynamic> authObj = json.decode(result);
    authHuaweiId = new AuthHuaweiId.fromJson(authObj);
    return authHuaweiId;
  }

  static Future<AuthHuaweiId> silentSignIn(AuthParamHelper authParamHelper) async {
    AuthHuaweiId authHuaweiId;
    final String isSignedInResult = await _channel.invokeMethod('silentSignIn', authParamHelper.authParamHelpers);
    Map<String, dynamic> silentSignInObj = json.decode(isSignedInResult);
    authHuaweiId = new AuthHuaweiId.fromJson(silentSignInObj);
    return authHuaweiId;
  }

  static Future<bool> signOut() async {
    bool signOutResult;
    try {
      signOutResult = await _channel.invokeMethod('signOut');
    } on Exception catch (exception) {
      print(exception.toString());
      signOutResult = false;
    } catch (error) {
      print(error.toString());
      signOutResult = false;
    }

    return signOutResult;
  }

  static Future<bool> revokeAuthorization() async {
    bool response;
    try {
      response = await _channel.invokeMethod('revokeAuthorization');
    } on Exception catch (exception) {
      response = false;
      print(exception.toString());
    } catch (error) {
      response = false;
      print(error.toString());
    }
    return response;
  }

  static Future<String> obtainHashCode() async {
    final String hashValue = await _channel.invokeMethod('obtainHashCode');
    return hashValue;
  }

  static Future smsVerification(SmsListener listener) async {
    _listener = listener;
    return await _channel.invokeMethod('smsVerification');
  }

  /// NETWORK TOOL

  static Future<String> buildNetworkUrl({@required String domainName, @required bool isHttps}) async {
    Map<String, dynamic> args = <String, dynamic>{
      'domainName': domainName,
      'isHttps': isHttps
    };
    final String cookie = await _channel.invokeMethod('buildNetworkUrl', args);
    return cookie;
  }

  static Future<String> buildNetworkCookie({@required String cookieName, @required String cookieValue, @required String domain, @required String path, @required bool isHttpOnly, @required bool isSecure, @required double maxAge}) async {
    Map<String, dynamic> args = <String, dynamic>{
      'cookieName': cookieName,
      'cookieValue': cookieValue,
      'domain': domain,
      'path': path,
      'isHttpOnly': isHttpOnly,
      'isSecure': isSecure,
      'maxAge': maxAge
    };
    final String combinedCookieData = await _channel.invokeMethod('buildNetworkCookie', args);
    return combinedCookieData;
  }

  /// HUAWEI ID AUTH TOOL

  static Future<bool> deleteAuthInfo({@required String accessToken}) async {
    bool deleteAuthInfoResult;
    Map<String, dynamic> args = <String, dynamic>{'accessToken': accessToken};

    try {
      deleteAuthInfoResult = await _channel.invokeMethod('deleteAuthInfo', args);
    } on Exception catch(exception) {
      print(exception.toString());
      deleteAuthInfoResult = false;
    } catch (error) {
      print(error.toString());
      deleteAuthInfoResult = false;
    }
    return deleteAuthInfoResult;
  }

  static Future<String> requestUnionId({@required String huaweiAccountName}) async {
    Map<String, dynamic> args = <String, dynamic>{
      'huaweiAccountName': huaweiAccountName
    };
    final String unionId = await _channel.invokeMethod('requestUnionId', args);
    return unionId;
  }

  static Future<String> requestAccessToken({@required Account account, @required List<String> scopeList}) async {
    Map<String, dynamic> param1 = <String, dynamic>{
      'accountData': {
        'accountType': account.type,
        'accountName': account.name,
        'scopeList': scopeList
      },
    };
    final String accessToken = await _channel.invokeMethod("requestAccessToken", param1);
    return accessToken;
  }

  /// HUAWEI ID AUTH MANAGER

  static Future<AuthHuaweiId> getAuthResult() async {
    AuthHuaweiId authHuaweiId;
    final String authResultJsonString = await _channel.invokeMethod('getAuthResult');
    Map<String, dynamic> obj = json.decode(authResultJsonString);
    authHuaweiId = new AuthHuaweiId.fromJson(obj);
    return authHuaweiId;
  }

  static Future<AuthHuaweiId> getAuthResultWithScopes({@required List<String> scopeList}) async {
    AuthHuaweiId authHuaweiId;
    Map<String, dynamic> scopes = <String, dynamic>{'scopeList': scopeList};
    Map<String, dynamic> requestParams = <String, dynamic>{
      'requestParams': json.encode(scopes)
    };
    final String authResultJsonString = await _channel.invokeMethod("getAuthResultWithScopes", requestParams);
    Map<String, dynamic> obj = json.decode(authResultJsonString);
    authHuaweiId = new AuthHuaweiId.fromJson(obj);
    return authHuaweiId;
  }

  static Future<bool> containScopes({@required Map<String, dynamic> authData, @required List<String> scopeList}) async {
    Map<String, dynamic> scopeParams = <String, dynamic>{
      'authInfo': {'authData': json.encode(authData), 'scopeList': scopeList}
    };
    final bool containScopesResponse = await _channel.invokeMethod('containScopes', scopeParams);
    return containScopesResponse;
  }

  static Future<bool> addAuthScopes({@required int requestCode, @required List<String> scopeList}) async {
    bool response;
    Map<String, dynamic> authParams = <String, dynamic>{
      'requestCode': requestCode,
      'scopes': scopeList
    };

    Map<String, dynamic> authRequestData = <String, dynamic>{
      'authScopeData': authParams
    };

    Map<String, dynamic> authParamsToSend = <String, dynamic>{
      'authScopes': json.encode(authRequestData)
    };

    try {
      response = await _channel.invokeMethod("addAuthScopes", authParamsToSend);
    } on Exception catch(exception) {
      print(exception.toString());
      response = false;
    } catch (error) {
      print(error.toString());
      response = false;
    }
    return response;
  }
}
