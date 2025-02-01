import 'package:car_api/models/body.dart';
import 'package:car_api/models/engine.dart';
import 'package:car_api/models/makes_res.dart';
import 'package:car_api/models/model_car.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/models/trim.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Keeper {
  MakesRequestRes makesRequestRes = MakesRequestRes.empty();
  ReqRes<ModelCar> modelCarRequestRes = ReqRes<ModelCar>.empty();
  ReqRes<Trim> trimReqRes = ReqRes<Trim>.empty();
  ReqRes<Engine> engineReqRes = ReqRes<Engine>.empty();
  ReqRes<Body> bodyReqRes = ReqRes<Body>.empty();
  String year_filter = '2020';
  String makes_id_filter = '0';
}

class DataCubit extends Cubit<Keeper> {
  ReqRes<Body> get getBodyReqRes => state.bodyReqRes;

  setBodyReqRes(ReqRes<Body> NewTrimReqRes) {
    state.bodyReqRes = NewTrimReqRes;
  }

  //---------------------------------------
  ReqRes<Engine> get getEngineReqRes => state.engineReqRes;

  setEngineReqRes(ReqRes<Engine> NewTrimReqRes) {
    state.engineReqRes = NewTrimReqRes;
  }

  //------------------------------------------------------------------

  ReqRes<Trim> get getTrimReqRes => state.trimReqRes;

  setTrimReqRes(ReqRes<Trim> NewTrimReqRes) {
    state.trimReqRes = NewTrimReqRes;
  }

  //------------------------------------------------------------------
  String get getYearFilter => state.year_filter;

  setYearFilter(String newValue) {
    state.year_filter = newValue;
  }

  //-------------------------------------------
  String get getMakesIdFilter => state.makes_id_filter;

  setMakesIdFilter(String newValue) {
    state.makes_id_filter = newValue;
  }

  //-------------------------------------------
  MakesRequestRes get getMakesRequestRes => state.makesRequestRes;

  setMakesRequestRes(MakesRequestRes result) {
    state.makesRequestRes = result;
  }

  ReqRes<ModelCar> get getModelCarRequestRes => state.modelCarRequestRes;

  setModelCarRequestRes(ReqRes<ModelCar> result) {
    state.modelCarRequestRes = result;
  }

  DataCubit(super.initState);
}
