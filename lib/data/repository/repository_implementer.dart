import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // it's connected to internet, it's safe to call API

      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return data
          return Right(response.toDomain());
        } else {
          // failure -- return business error
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      // return internet connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      // it's connected to internet, it's safe to call API

      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return data
          return Right(response.toDomain());
        } else {
          // failure -- return business error
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      // return internet connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      // it's connected to internet, it's safe to call API

      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return data
          return Right(response.toDomain());
        } else {
          // failure -- return business error
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      // return internet connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
