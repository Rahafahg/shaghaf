import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moyasar/moyasar.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/user_screens/other/bloc/booking_bloc.dart';
import 'package:shaghaf/screens/user_screens/other/user_ticket_screen.dart';
import 'package:shaghaf/widgets/buttons/date_radio_button.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/dialogs/mayasor.dart';

class WorkshopDetailScreen extends StatelessWidget {
  final WorkshopGroupModel workshop;
  final String? date;
  const WorkshopDetailScreen({super.key, required this.workshop, this.date});

  @override
  Widget build(BuildContext context) {
    final category = GetIt.I
        .get<DataLayer>()
        .categories
        .firstWhere((category) => category.categoryId == workshop.categoryId);
    final selectedDate = date != null && date!.isNotEmpty
        ? date!.split('-').last
        : workshop.workshops.first.date.split('-').last;
    Workshop specific = workshop.workshops
        .where((workshop) => workshop.date.contains(selectedDate))
        .toList()
        .first;
    return BlocProvider(
      create: (context) => BookingBloc()
        ..add(UpdateDayEvent(selectedDate: selectedDate, specific: specific)),
      child: Builder(builder: (context) {
        final bloc = context.read<BookingBloc>();
        return BlocListener<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is SuccessState) {
              context.pushReplacement(screen: const UserTicketScreen());
            }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        workshop.image,
                        width: context.getWidth(),
                        height: context.getHeight(divideBy: 3),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 40.0,
                        left: 16.0,
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Constants.lightGreen,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Image.asset(category.icon),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              workshop.title,
                              style: const TextStyle(
                                  color: Constants.textColor,
                                  fontSize: 20,
                                  fontFamily: "Poppins"),
                            ),
                            Row(
                              children: [
                                const HugeIcon(
                                  icon: HugeIcons.strokeRoundedUserGroup,
                                  color: Constants.textColor,
                                ),
                                const SizedBox(width: 5),
                                Text(workshop.targetedAudience)
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 5),
                                Text(
                                  category.categoryName,
                                  style: const TextStyle(
                                      color: Constants.textColor,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          "assets/images/Organizer_image.jpg")),
                                ),
                                const SizedBox(width: 5),
                                const Text("Organizer"),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: Constants.dividerColor,
                          thickness: 1,
                        ),
                        const Text(
                          "Description",
                        ),
                        const SizedBox(height: 5),
                        Text(workshop.description,
                            style: const TextStyle(
                                color: Constants.lightTextColor, fontSize: 14)),
                        const Divider(
                          color: Constants.dividerColor,
                          thickness: 1,
                        ),
                        const Text(
                          "Instructor",
                        ),
                        BlocBuilder<BookingBloc, BookingState>(
                          builder: (context, state) {
                            if (state is ChangeQuantityState) {
                              if (state.specific != null) {
                                specific = state.specific!;
                                return Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          state.specific!.instructorImage,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      state.specific!.instructorName,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                );
                              }
                            }
                            return Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      specific.instructorImage,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  specific.instructorName,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 5),
                        BlocBuilder<BookingBloc, BookingState>(
                          builder: (context, state) {
                            if (state is ChangeQuantityState) {
                              if (state.specific != null) {
                                specific = state.specific!;
                                return Text(
                                  state.specific!.instructorDescription,
                                  style: const TextStyle(
                                      color: Constants.lightTextColor,
                                      fontSize: 14),
                                );
                              }
                            }
                            return Text(
                              specific.instructorDescription,
                              style: const TextStyle(
                                  color: Constants.lightTextColor,
                                  fontSize: 14),
                            );
                          },
                        ),
                        const Divider(
                          color: Constants.dividerColor,
                          thickness: 1,
                        ),
                        const Text(
                          "Available Days",
                        ),
                        const SizedBox(height: 10),
                        DateRadioButton(
                            onTap: (chosenDay) => bloc.add(UpdateDayEvent(
                                  selectedDate: chosenDay.split(' ')[1],
                                  specific: workshop.workshops
                                      .where((workshop) => workshop.date
                                          .contains(chosenDay.split(' ')[1]))
                                      .toList()
                                      .first,
                                )),
                            workshop: workshop.workshops,
                            selectedDate: selectedDate),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Available Seats",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const HugeIcon(
                                icon: HugeIcons.strokeRoundedSeatSelector,
                                color: Constants.mainOrange),
                            const SizedBox(
                              width: 10,
                            ),
                            BlocBuilder<BookingBloc, BookingState>(
                              builder: (context, state) {
                                if (state is ChangeQuantityState) {
                                  if (state.specific != null) {
                                    specific = state.specific!;
                                    return Text(
                                        "${specific.availableSeats}/${specific.numberOfSeats}");
                                  }
                                }
                                return Text(
                                    "${specific.availableSeats}/${specific.numberOfSeats}");
                              },
                            ),
                          ],
                        ),
                        const Divider(
                          color: Constants.dividerColor,
                          thickness: 1,
                        ),
                        const Text(
                          "Location",
                        ),
                        Row(
                          children: [
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedLocation01,
                              color: Constants.mainOrange,
                            ),
                            const SizedBox(width: 8),
                            BlocBuilder<BookingBloc, BookingState>(
                              builder: (context, state) {
                                if (state is ChangeQuantityState) {
                                  if (state.specific != null) {
                                    specific = state.specific!;
                                    return Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(state.specific!.isOnline
                                            ? 'Online'
                                            : state.specific!.venueName ??
                                                "To be determained later"),
                                        subtitle: Text(
                                          specific.isOnline
                                              ? 'Online'
                                              : specific.venueType ??
                                                  "To be determained later",
                                          style: const TextStyle(
                                              color: Constants.lightTextColor,
                                              fontSize: 14),
                                        ),
                                      ),
                                    );
                                  }
                                }
                                return Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(specific.isOnline
                                        ? 'Online'
                                        : specific.venueName ??
                                            "To be determained later"),
                                    subtitle: Text(
                                      specific.isOnline
                                          ? 'Online'
                                          : specific.venueType ??
                                              "To be determained later",
                                      style: const TextStyle(
                                          color: Constants.lightTextColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        BlocBuilder<BookingBloc, BookingState>(
                          builder: (context, state) {
                            if (state is ChangeQuantityState) {
                              if (state.specific != null) {
                                specific = state.specific!;
                                return state.specific!.isOnline
                                    ? SizedBox.shrink()
                                    : Center(
                                        child: Image.asset(
                                            "assets/images/map_defult.png"));
                              }
                            }
                            return specific.isOnline
                                ? SizedBox.shrink()
                                : Center(
                                    child: Image.asset(
                                        "assets/images/map_defult.png"));
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<BookingBloc, BookingState>(
                          builder: (context, state) {
                            if (state is ChangeQuantityState) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            bloc.add(AddQuantityEvent());
                                            log(bloc.quantity.toString());
                                          },
                                          icon: const HugeIcon(
                                              icon: HugeIcons
                                                  .strokeRoundedPlusSignSquare,
                                              color: Constants.mainOrange)),
                                      Text("${state.quantity}"),
                                      IconButton(
                                          onPressed: () {
                                            bloc.add(ReduceQuantityEvent());
                                            log(bloc.quantity.toString());
                                          },
                                          icon: const HugeIcon(
                                              icon: HugeIcons
                                                  .strokeRoundedMinusSignSquare,
                                              color: Constants.mainOrange))
                                    ],
                                  ),
                                  MainButton(
                                    text:
                                        "Pay ${specific.price * state.quantity} SR",
                                           onPressed: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.all(24),
                                        width: context.getWidth(),
                                        height:
                                            context.getHeight(divideBy: 1.35),
                                        decoration: const BoxDecoration(
                                          color: Constants.backgroundColor,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          children: [
                                            const Text("Fill Card Info",
                                                style: TextStyle(fontSize: 20)),
                                            Theme(
                                              data: ThemeData(
                                                  textTheme: const TextTheme()),
                                              child: CreditCard(
                                                config: PaymentConfig(
                                                  creditCard: CreditCardConfig(
                                                      saveCard: false,
                                                      manual: false),
                                                  publishableApiKey: dotenv
                                                      .env['MOYASAR_KEY']!,
                                                  amount: ((workshop.workshops
                                                              .last.price *
                                                          bloc.quantity *
                                                          100))
                                                      .toInt(),
                                                  description: "description",
                                                ),
                                                onPaymentResult:
                                                    (PaymentResponse
                                                        result) async {
                                                  if (result.status ==
                                                      PaymentStatus.paid) {
                                                    log("Payment is donnee ${result.status}");
                                                    bloc.add(SaveBookingEvent(
                                                        workshop: workshop.workshops.first,
                                                        quantity: bloc.quantity,
                                                        
                                                        ));
                                                  } else {}
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  )
                                ],
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          bloc.add(AddQuantityEvent());
                                          log(bloc.quantity.toString());
                                        },
                                        icon: const HugeIcon(
                                            icon: HugeIcons
                                                .strokeRoundedPlusSignSquare,
                                            color: Constants.mainOrange)),
                                    Text("${bloc.quantity}"),
                                    IconButton(
                                        onPressed: () {
                                          bloc.add(ReduceQuantityEvent());
                                          log(bloc.quantity.toString());
                                        },
                                        icon: const HugeIcon(
                                            icon: HugeIcons
                                                .strokeRoundedMinusSignSquare,
                                            color: Constants.mainOrange))
                                  ],
                                ),
                                MainButton(
                                  text:
                                      "Pay ${specific.price * bloc.quantity} SR",
                                      onPressed: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.all(24),
                                        width: context.getWidth(),
                                        height:
                                            context.getHeight(divideBy: 1.35),
                                        decoration: const BoxDecoration(
                                          color: Constants.backgroundColor,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          children: [
                                            const Text("Fill Card Info",
                                                style: TextStyle(fontSize: 20)),
                                            Theme(
                                              data: ThemeData(
                                                  textTheme: const TextTheme()),
                                              child: CreditCard(
                                                config: PaymentConfig(
                                                  creditCard: CreditCardConfig(
                                                      saveCard: false,
                                                      manual: false),
                                                  publishableApiKey: dotenv
                                                      .env['MOYASAR_KEY']!,
                                                  amount: ((workshop.workshops
                                                              .last.price *
                                                          bloc.quantity *
                                                          100))
                                                      .toInt(),
                                                  description: "description",
                                                ),
                                                onPaymentResult:
                                                    (PaymentResponse
                                                        result) async {
                                                  if (result.status ==
                                                      PaymentStatus.paid) {
                                                    log("Payment is donnee ${result.status}");
                                                    bloc.add(SaveBookingEvent(
                                                        workshop: workshop.workshops.first,
                                                        quantity: bloc.quantity,
                                                        
                                                        ));
                                                  } else {}
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
