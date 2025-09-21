import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial());

  void initializeDelivery() {
    emit(DeliveryLoading());

    // Simulate initialization
    Future.delayed(const Duration(seconds: 1), () {
      emit(DeliveryLoaded());
    });
  }

  void refreshDelivery() {
    emit(DeliveryLoading());

    // Simulate refresh
    Future.delayed(const Duration(seconds: 1), () {
      emit(DeliveryLoaded());
    });
  }
}
