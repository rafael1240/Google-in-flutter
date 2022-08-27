import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'api.dart';
import 'package:viacepflutter/model/cepModel.dart';

class DataController{
  final api = API();
  final cep = "";
  Future<cepModel?> getCep (cep) async{
    try {
      final response = await api.get("https://viacep.com.br/ws/${cep}/json/");
      if(response?.statusCode == 200){
        return cepModel.fromJson(json.decode(json.encode(response?.data)));
      }
    } catch (e) {

    }
  }
}