import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/authenticated_model.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/user_data_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthenticatedModel> login(LoginModel loginModel);
  Future<Unit> register(RegisterModel registerModel);
  Future<UserDataModel> getUser(String token);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserDataModel> getUser(String token) async {
    var uri = Uri.parse('${Urls.authUrl}/users/me');
    try {
      final response =
          await client.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return UserDataModel.fromJson(json.decode(response.body)['data']);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException('No Internet Connection');
    }
  }

  @override
  Future<AuthenticatedModel> login(LoginModel loginModel) async {
    var uri = Uri.parse('${Urls.authUrl}/auth/login');
    try {
      final response = await client.post(uri, body: loginModel.toJson());
      if (response.statusCode == 201) {
        return AuthenticatedModel.fromJson(json.decode(response.body)['data']);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException('No Internet Connection');
    }
  }

  @override
  Future<Unit> register(RegisterModel registerModel) async {
    var uri = Uri.parse('${Urls.authUrl}/auth/register');

    try {
      final response = await client.post(uri, body: registerModel.toJson());
      if (response.statusCode == 201) {
        return unit;
      } else if (response.statusCode == 409) {
        throw UserAlreadyExistsException();
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException('No Internet Connection');
    }
  }
}
