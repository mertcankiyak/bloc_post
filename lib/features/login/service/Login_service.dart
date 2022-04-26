import 'package:bloc_post/features/login/model/request_model.dart';
import 'package:bloc_post/features/login/model/response_model.dart';
import 'package:bloc_post/product/enums/service_enums.dart';
import 'package:bloc_post/product/extensions/service_extensions.dart';
import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';
import 'package:bloc_post/features/login/service/ILogin_service.dart';

class LoginService extends ILoginService {
  final NetworkManager _networkManager = NetworkManager(
      options: BaseOptions(baseUrl: ServiceEnum.BASEURL.rawValue()));

  @override
  Future<ResponseTokenModel?> login({RequestUserModel? requestModel}) async {
    final response =
        await _networkManager.send<ResponseTokenModel, ResponseTokenModel>(
            ServiceEnum.LOGINPATH.rawValue(),
            parseModel: ResponseTokenModel(),
            method: RequestType.POST,
            data: requestModel?.toJson());
    return response.data;
  }
}
