import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/directions_model.dart';

class DirectionRepository {
  static const String _baseUrl = "https://maps.googleapis.com/maps/api/directions/json?";
  Dio? _dio;
  DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections ({required LatLng origin,required LatLng destination}) async{
    final response = await _dio!.get(_baseUrl,
        queryParameters: {
          "origin": "${origin.latitude},${origin.longitude}",
          "destination" : "${destination.latitude},${destination.longitude}",
          "key" : "AIzaSyC6S3BAvLFoMWJGVB0erqfDz0PPxWYhq08"
    });
    if(response.statusCode == 200){
      return Directions.fromMap(response.data);
    }
    return null;
}

}