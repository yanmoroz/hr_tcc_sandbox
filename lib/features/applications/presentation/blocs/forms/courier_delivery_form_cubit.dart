import 'package:flutter_bloc/flutter_bloc.dart';

enum CourierTripGoal { deliver, pickUp, deliverAndPickUp }

class CourierDeliveryFormState {
  final String? city;
  final String? emailFrom;
  final String? office;
  final String? manager;
  final String? contactPhone;
  final CourierTripGoal? tripGoal;
  final DateTime? date;
  final String? timeFrom;
  final String? timeTo;
  final String? destCompany;
  final String? destAddress;
  final String? destFio;
  final String? destPhone;
  final String? destEmail;
  final bool addComment;
  final String? comment;

  const CourierDeliveryFormState({
    this.city,
    this.emailFrom,
    this.office,
    this.manager,
    this.contactPhone,
    this.tripGoal,
    this.date,
    this.timeFrom,
    this.timeTo,
    this.destCompany,
    this.destAddress,
    this.destFio,
    this.destPhone,
    this.destEmail,
    this.addComment = false,
    this.comment,
  });

  bool get isValid =>
      city != null &&
      office != null &&
      date != null &&
      destAddress != null &&
      destAddress!.trim().isNotEmpty &&
      destFio != null &&
      destFio!.trim().isNotEmpty &&
      destPhone != null &&
      destPhone!.trim().isNotEmpty;

  CourierDeliveryFormState copyWith({
    String? city,
    String? emailFrom,
    String? office,
    String? manager,
    String? contactPhone,
    CourierTripGoal? tripGoal,
    DateTime? date,
    bool clearDate = false,
    String? timeFrom,
    bool clearTimeFrom = false,
    String? timeTo,
    bool clearTimeTo = false,
    String? destCompany,
    String? destAddress,
    String? destFio,
    String? destPhone,
    String? destEmail,
    bool? addComment,
    String? comment,
    bool clearComment = false,
  }) {
    return CourierDeliveryFormState(
      city: city ?? this.city,
      emailFrom: emailFrom ?? this.emailFrom,
      office: office ?? this.office,
      manager: manager ?? this.manager,
      contactPhone: contactPhone ?? this.contactPhone,
      tripGoal: tripGoal ?? this.tripGoal,
      date: clearDate ? null : (date ?? this.date),
      timeFrom: clearTimeFrom ? null : (timeFrom ?? this.timeFrom),
      timeTo: clearTimeTo ? null : (timeTo ?? this.timeTo),
      destCompany: destCompany ?? this.destCompany,
      destAddress: destAddress ?? this.destAddress,
      destFio: destFio ?? this.destFio,
      destPhone: destPhone ?? this.destPhone,
      destEmail: destEmail ?? this.destEmail,
      addComment: addComment ?? this.addComment,
      comment: clearComment ? null : (comment ?? this.comment),
    );
  }
}

class CourierDeliveryFormCubit extends Cubit<CourierDeliveryFormState> {
  CourierDeliveryFormCubit() : super(const CourierDeliveryFormState());

  void setCity(String v) => emit(state.copyWith(city: v));
  void setEmailFrom(String v) => emit(state.copyWith(emailFrom: v));
  void setOffice(String v) => emit(state.copyWith(office: v));
  void setManager(String v) => emit(state.copyWith(manager: v));
  void setContactPhone(String v) => emit(state.copyWith(contactPhone: v));
  void setTripGoal(CourierTripGoal v) => emit(state.copyWith(tripGoal: v));
  void setDate(DateTime d) => emit(state.copyWith(date: d));
  void setTimeFrom(String v) => emit(state.copyWith(timeFrom: v));
  void setTimeTo(String v) => emit(state.copyWith(timeTo: v));
  void setDestCompany(String v) => emit(state.copyWith(destCompany: v));
  void setDestAddress(String v) => emit(state.copyWith(destAddress: v));
  void setDestFio(String v) => emit(state.copyWith(destFio: v));
  void setDestPhone(String v) => emit(state.copyWith(destPhone: v));
  void setDestEmail(String v) => emit(state.copyWith(destEmail: v));
  void setAddComment(bool v) => emit(state.copyWith(addComment: v));
  void setComment(String v) => emit(state.copyWith(comment: v));
}
