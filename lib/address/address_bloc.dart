import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halmoney/address/address_event.dart';
import 'package:halmoney/address/address_state.dart';
import 'package:halmoney/address/address_depth_model.dart';
import 'package:halmoney/address/address_model.dart';
import 'package:halmoney/address/address_repository.dart';

class AddressDepthBloc extends Bloc<AddressDepthEvent, AddressDepthState> {
  final AppAddressRepository _repository = AppAddressRepository.instance;
  AddressDepthBloc()
      : super(AddressDepthInitState(address: AddressDepthModel.empty())) {
    on<AddressDepthMajorEvent>(_major);
    on<AddressDepthMiddleEvent>(_middle);
    on<AddressDepthMinorEvent>(_minor);
    on<AddressDepthFinishEvent>(_finish);
    on<AddressDepthResetEvent>(_reset);
    add(AddressDepthMajorEvent());
  }

  Future<void> _major(
      AddressDepthMajorEvent event, Emitter<AddressDepthState> emit) async {
    if (state.address!.major.address.isEmpty) {
      String? token = state.accessToken;
      if (token == null) {
        String? result = await _repository.getSgisApiAccessToken();
        if (result == null) {
          emit(AddressDepthErrorState(address: state.address));
        } else {
          token = result;
        }
      }
      if (token != null) {
        List<AddressDepthServerModel> result =
        await _repository.depthAddressInformation(token: token);
        if (result.isNotEmpty) {
          emit(AddressDepthMajorState(
              address: state.address!.coptyWith(
                major: AddressDepthDetailModel(current: null, address: result),
              ),
              accessToken: token));
        } else {
          emit(AddressDepthErrorState(address: state.address));
        }
      }
    }
  }

  Future<void> _middle(
      AddressDepthMiddleEvent event, Emitter<AddressDepthState> emit) async {
    HapticFeedback.mediumImpact();
    List<AddressDepthServerModel> result =
    await _repository.depthAddressInformation(
        token: state.accessToken!, code: event.selected.code);
    if (result.isNotEmpty) {
      emit(AddressDepthMiddleState(
          address: state.address!.coptyWith(
            major: state.address!.major.copyWith(current: event.selected),
            middle: AddressDepthDetailModel(current: null, address: result),
          ),
          accessToken: state.accessToken));
    } else {
      emit(AddressDepthErrorState(address: state.address));
    }
  }

  Future<void> _minor(
      AddressDepthMinorEvent event, Emitter<AddressDepthState> emit) async {
    HapticFeedback.mediumImpact();
    List<AddressDepthServerModel> result =
    await _repository.depthAddressInformation(
        token: state.accessToken!, code: event.selected.code);
    if (result.isNotEmpty) {
      emit(AddressDepthMinorState(
          address: state.address!.coptyWith(
            middle: state.address!.middle.copyWith(current: event.selected),
            minor: AddressDepthDetailModel(current: null, address: result),
          ),
          accessToken: state.accessToken));
    } else {
      emit(AddressDepthErrorState(address: state.address));
    }
  }

  Future<void> _finish(
      AddressDepthFinishEvent event, Emitter<AddressDepthState> emit) async {
    HapticFeedback.mediumImpact();
    emit(AddressDepthMinorState(
        address: state.address!.coptyWith(
            minor: state.address!.minor.copyWith(current: event.selected)),
        accessToken: state.accessToken));
  }

  Future<void> _reset(
      AddressDepthResetEvent event, Emitter<AddressDepthState> emit) async {
    HapticFeedback.mediumImpact();
    switch (event.type) {
      case 0:
        emit(AddressDepthMajorState(
            address: state.address!.coptyWith(
              major: state.address!.major.copyWith(current: null),
              middle: state.address!.middle.copyWith(current: null),
              minor: state.address!.minor.copyWith(current: null),
            ),
            accessToken: state.accessToken));
        break;
      case 1:
        emit(AddressDepthMiddleState(
          address: state.address!
              .coptyWith(minor: state.address!.minor.copyWith(current: null)),
          accessToken: state.accessToken,
        ));
        break;
      default:
    }
  }

  @override
  void onChange(Change<AddressDepthState> change) {
    super.onChange(change);
  }
}