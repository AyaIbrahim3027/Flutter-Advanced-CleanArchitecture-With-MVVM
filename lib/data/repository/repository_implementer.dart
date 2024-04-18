import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource ;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource,this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
      // it's connected to internet, it's safe to call API
      final response = await _remoteDataSource.login(loginRequest);
      if(response.status == 0){
        // success
        // return data
        return Right(response.toDomain());
      } else {
        // failure -- return business error
        return Left(Failure(409, response.message ?? "business error message"));
      }
    } else {
      // return internet connection error
      return Left(Failure(501,"please check your internet connection"));
    }
  }
  
}