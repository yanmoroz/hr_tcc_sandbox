import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../domain/entities/application_type.dart';
import '../blocs/new_application_bloc.dart';
import '../blocs/new_application_event.dart';
import '../blocs/new_application_state.dart';
// Removed direct field widget imports; forms handle their own
import '../widgets/forms/employment_certificate_form.dart';
import '../widgets/forms/parking_form.dart';
import '../widgets/forms/absence_form.dart';
import '../widgets/forms/violation_form.dart';
import '../widgets/forms/ndfl_certificate_form.dart';
import '../widgets/forms/employment_record_copy_form.dart';
import '../widgets/forms/referral_program_form.dart';
import '../widgets/forms/additional_education_form.dart';
import '../widgets/forms/internal_training_form.dart';
import '../widgets/forms/alpina_digital_access_form.dart';
import '../widgets/forms/business_trip_form.dart';
import '../widgets/forms/access_card_form.dart';
import '../widgets/forms/courier_delivery_form.dart';
import '../widgets/forms/unplanned_training_form.dart';
import '../blocs/forms/employment_certificate_form_cubit.dart';
import '../blocs/forms/parking_form_cubit.dart';
import '../blocs/forms/absence_form_cubit.dart';
import '../blocs/forms/violation_form_cubit.dart';
import '../blocs/forms/ndfl_certificate_form_cubit.dart';
import '../blocs/forms/employment_record_copy_form_cubit.dart';
import '../blocs/forms/referral_program_form_cubit.dart';
import '../blocs/forms/additional_education_form_cubit.dart';
import '../blocs/forms/internal_training_form_cubit.dart';
import '../blocs/forms/alpina_digital_access_form_cubit.dart';
import '../blocs/forms/business_trip_form_cubit.dart';
import '../blocs/forms/access_card_form_cubit.dart';
import '../blocs/forms/courier_delivery_form_cubit.dart';
import '../blocs/forms/unplanned_training_form_cubit.dart';

class NewApplicationPage extends StatefulWidget {
  final ApplicationType applicationType;

  const NewApplicationPage({super.key, required this.applicationType});

  @override
  State<NewApplicationPage> createState() => _NewApplicationPageState();
}

class _NewApplicationPageState extends State<NewApplicationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewApplicationBloc>().add(
      NewApplicationStarted(widget.applicationType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const AppTopBar(title: 'Создание заявки'),
      body: SafeArea(
        child: BlocConsumer<NewApplicationBloc, NewApplicationState>(
          listener: (context, state) {
            if (state.createdId != null) {
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: _ApplicationSuccessModal(
                    onClose: () => Navigator.of(context).pop(),
                  ),
                ),
              ).whenComplete(() => Navigator.of(context).pop());
            }
          },
          builder: (context, state) {
            // Local submit enable/handler depending on form type
            bool canSubmit = false;
            VoidCallback? onSubmit;

            Widget formWidget = const SizedBox.shrink();

            if (widget.applicationType ==
                ApplicationType.employmentCertificate) {
              if (state.isLoading) {
                formWidget = const Center(child: CircularProgressIndicator());
              } else {
                formWidget = BlocProvider(
                  create: (_) =>
                      EmploymentCertificateFormCubit()
                        ..setPurposes(state.purposes),
                  child:
                      BlocBuilder<
                        EmploymentCertificateFormCubit,
                        EmploymentCertificateFormState
                      >(
                        builder: (context, ecState) {
                          canSubmit = ecState.isValid && !state.isSubmitting;
                          onSubmit = canSubmit
                              ? () => context.read<NewApplicationBloc>().add(
                                  EmploymentCertificateSubmitted(
                                    purposeId: ecState.selectedPurposeId!,
                                    receiveDate: ecState.receiveDate!,
                                    copies: ecState.copies,
                                  ),
                                )
                              : null;
                          return EmploymentCertificateForm(state: ecState);
                        },
                      ),
                );
              }
            } else if (widget.applicationType == ApplicationType.parking) {
              formWidget = BlocProvider(
                create: (_) => ParkingFormCubit(),
                child: BlocBuilder<ParkingFormCubit, ParkingFormState>(
                  builder: (context, pState) {
                    // TODO: Hook submit once backend contract is defined
                    canSubmit = pState.isValid && !state.isSubmitting;
                    onSubmit = null; // no submit route yet
                    return ParkingForm(state: pState);
                  },
                ),
              );
            } else if (widget.applicationType == ApplicationType.absence) {
              formWidget = BlocProvider(
                create: (_) => AbsenceFormCubit(),
                child: BlocBuilder<AbsenceFormCubit, AbsenceFormState>(
                  builder: (context, aState) {
                    // TODO: Hook submit once backend contract is defined
                    canSubmit = aState.isValid && !state.isSubmitting;
                    onSubmit = null; // no submit route yet
                    return AbsenceForm(state: aState);
                  },
                ),
              );
            } else if (widget.applicationType == ApplicationType.violation) {
              formWidget = BlocProvider(
                create: (_) => ViolationFormCubit(),
                child: BlocBuilder<ViolationFormCubit, ViolationFormState>(
                  builder: (context, vState) {
                    // TODO: Wire submit once endpoint is ready
                    canSubmit = vState.isValid && !state.isSubmitting;
                    onSubmit = null; // no submit route yet
                    return ViolationForm(state: vState);
                  },
                ),
              );
            } else if (widget.applicationType ==
                ApplicationType.ndflCertificate) {
              formWidget = BlocProvider(
                create: (_) => NdflCertificateFormCubit(),
                child:
                    BlocBuilder<
                      NdflCertificateFormCubit,
                      NdflCertificateFormState
                    >(
                      builder: (context, nState) {
                        // TODO: Wire submit once endpoint is ready
                        canSubmit = nState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit route yet
                        return NdflCertificateForm(state: nState);
                      },
                    ),
              );
            } else if (widget.applicationType ==
                ApplicationType.employmentRecordCopy) {
              formWidget = BlocProvider(
                create: (_) => EmploymentRecordCopyFormCubit(),
                child:
                    BlocBuilder<
                      EmploymentRecordCopyFormCubit,
                      EmploymentRecordCopyFormState
                    >(
                      builder: (context, ercState) {
                        // TODO: Wire submit once endpoint is ready
                        canSubmit = ercState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit route yet
                        return EmploymentRecordCopyForm(state: ercState);
                      },
                    ),
              );
            } else if (widget.applicationType ==
                ApplicationType.referralProgram) {
              formWidget = BlocProvider(
                create: (_) => ReferralProgramFormCubit(),
                child:
                    BlocBuilder<
                      ReferralProgramFormCubit,
                      ReferralProgramFormState
                    >(
                      builder: (context, rpState) {
                        // TODO: Wire submit once endpoint is ready
                        canSubmit = rpState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit route yet
                        return ReferralProgramForm(state: rpState);
                      },
                    ),
              );
            } else if (widget.applicationType ==
                ApplicationType.additionalEducation) {
              formWidget = BlocProvider(
                create: (_) => AdditionalEducationFormCubit(),
                child:
                    BlocBuilder<
                      AdditionalEducationFormCubit,
                      AdditionalEducationFormState
                    >(
                      builder: (context, aeState) {
                        // TODO: Wire submit once endpoint is ready
                        canSubmit = aeState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit route yet
                        return AdditionalEducationForm(state: aeState);
                      },
                    ),
              );
            } else if (widget.applicationType ==
                ApplicationType.internalTraining) {
              formWidget = BlocProvider(
                create: (_) => InternalTrainingFormCubit(),
                child:
                    BlocBuilder<
                      InternalTrainingFormCubit,
                      InternalTrainingFormState
                    >(
                      builder: (context, itState) {
                        // TODO: Wire submit once endpoint is ready
                        canSubmit = itState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit route yet
                        return InternalTrainingForm(state: itState);
                      },
                    ),
              );
            } else if (widget.applicationType ==
                ApplicationType.alpinaDigitalAccess) {
              formWidget = BlocProvider(
                create: (_) => AlpinaDigitalAccessFormCubit(),
                child:
                    BlocBuilder<
                      AlpinaDigitalAccessFormCubit,
                      AlpinaDigitalAccessFormState
                    >(
                      builder: (context, aState) {
                        // TODO: Wire submit once endpoint is ready
                        canSubmit = aState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit route yet
                        return AlpinaDigitalAccessForm(state: aState);
                      },
                    ),
              );
            } else if (widget.applicationType == ApplicationType.businessTrip) {
              formWidget = BlocProvider(
                create: (_) => BusinessTripFormCubit(),
                child:
                    BlocBuilder<BusinessTripFormCubit, BusinessTripFormState>(
                      builder: (context, btState) {
                        // TODO: Wire submit once endpoint is ready
                        canSubmit = btState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit route yet
                        return BusinessTripForm(state: btState);
                      },
                    ),
              );
            } else if (widget.applicationType == ApplicationType.accessCard) {
              formWidget = BlocProvider(
                create: (_) => AccessCardFormCubit(),
                child: BlocBuilder<AccessCardFormCubit, AccessCardFormState>(
                  builder: (context, acState) {
                    canSubmit = acState.isValid && !state.isSubmitting;
                    onSubmit = null;
                    return AccessCardForm(state: acState);
                  },
                ),
              );
            } else if (widget.applicationType ==
                ApplicationType.courierDelivery) {
              formWidget = BlocProvider(
                create: (_) => CourierDeliveryFormCubit(),
                child:
                    BlocBuilder<
                      CourierDeliveryFormCubit,
                      CourierDeliveryFormState
                    >(
                      builder: (context, cdState) {
                        canSubmit = cdState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit yet
                        return CourierDeliveryForm(state: cdState);
                      },
                    ),
              );
            } else if (widget.applicationType ==
                ApplicationType.unplannedTraining) {
              formWidget = BlocProvider(
                create: (_) => UnplannedTrainingFormCubit(),
                child:
                    BlocBuilder<
                      UnplannedTrainingFormCubit,
                      UnplannedTrainingFormState
                    >(
                      builder: (context, utState) {
                        canSubmit = utState.isValid && !state.isSubmitting;
                        onSubmit = null; // no submit yet
                        return UnplannedTrainingForm(state: utState);
                      },
                    ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.applicationType.displayName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        formWidget,
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canSubmit
                            ? const Color(0xFF12369F)
                            : Colors.grey[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Создать'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ApplicationSuccessModal extends StatelessWidget {
  final VoidCallback onClose;

  const _ApplicationSuccessModal({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF35B36A), width: 6),
              ),
              child: const Center(
                child: Icon(Icons.check, size: 56, color: Color(0xFF35B36A)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Заявка создана',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
