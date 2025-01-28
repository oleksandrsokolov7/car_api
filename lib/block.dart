import 'package:car_api/models/makes_res.dart';
import 'package:car_api/models/model_car_res.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/models/trim.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Keeper {
  MakesRequestRes makesRequestRes = MakesRequestRes.empty();
  ModelCarRequestRes modelCarRequestRes = ModelCarRequestRes.empty();
  ReqRes<Trim> trimReqRes = ReqRes<Trim>.empty();
  String year_filter_model_car = '2020';
  String makes_id_filter_model_car = '0';
}

class DataCubit extends Cubit<Keeper> {
  ReqRes<Trim> get getTrimReqRes => state.trimReqRes;

  setTrimReqRes(ReqRes<Trim> NewTrimReqRes) {
    state.trimReqRes = NewTrimReqRes;
  }

  //------------------------------------------------------------------
  String get getYearFilterModelCar => state.year_filter_model_car;

  setYearFilterModelCar(String newValue) {
    state.year_filter_model_car = newValue;
  }

  //-------------------------------------------
  String get getMakesIdFilterModelCar => state.makes_id_filter_model_car;

  setMakesIdFilterModelCar(String newValue) {
    state.makes_id_filter_model_car = newValue;
  }

  //-------------------------------------------
  MakesRequestRes get getMakesRequestRes => state.makesRequestRes;

  setMakesRequestRes(MakesRequestRes result) {
    state.makesRequestRes = result;
  }

  ModelCarRequestRes get getModelCarRequestRes => state.modelCarRequestRes;

  setModelCarRequestRes(ModelCarRequestRes result) {
    state.modelCarRequestRes = result;
  }

  DataCubit(super.initState);
}
