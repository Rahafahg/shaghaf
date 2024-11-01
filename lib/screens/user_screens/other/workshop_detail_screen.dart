import 'dart:developer';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moyasar/moyasar.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/add_workshop_screen.dart';
import 'package:shaghaf/screens/user_screens/other/bloc/booking_bloc.dart';
import 'package:shaghaf/screens/user_screens/other/user_ticket_screen.dart';
import 'package:shaghaf/widgets/buttons/date_radio_button.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/cards/ticket_card.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';
import 'package:shaghaf/widgets/maps/user_map.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkshopDetailScreen extends StatelessWidget {
  final WorkshopGroupModel workshop;
  final String? date;
  const WorkshopDetailScreen({super.key, required this.workshop, this.date});

  @override
  Widget build(BuildContext context) {
    final organizer = GetIt.I.get<AuthLayer>().organizer;
    final category = GetIt.I.get<DataLayer>().categories.firstWhere((category) => category.categoryId == workshop.categoryId);
    String selectedDate = int.parse(date != null && date!.isNotEmpty ? date!.split('-').last : workshop.workshops.first.date.split('-').last).toString();
    Workshop specific = workshop.workshops.where((workshop) => workshop.date.contains(selectedDate)).toList().first;
    return BlocProvider(
      create: (context) => BookingBloc()
        ..add(UpdateDayEvent(selectedDate: selectedDate, specific: specific)),
      child: Builder(builder: (context) {
        log(specific.instructorName);
        final bloc = context.read<BookingBloc>();
        return BlocListener<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is SuccessState) {
              context.pushReplacement(
                  screen: UserTicketScreen(
                      workshop: specific, booking: state.booking));
            }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // workshop image
                  Stack(
                    children: [
                      Image.network(
                        workshop.image,
                        width: context.getWidth(),
                        height: context.getHeight(divideBy: 3),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: ()=>context.pop(), icon: const Icon(Icons.arrow_back_ios, color: Colors.lightGreen, size: 28,)),
                            organizer==null ? const SizedBox.shrink() : IconButton(onPressed: ()=>context.push(screen: AddWorkshopScreen(
                              isSingleWorkShope: true, workshop: specific, isEdit: true
                              )), icon: const Icon(Icons.edit, color: Colors.lightGreen, size: 28,))
                          ],
                        ),
                      )
                      // Positioned(
                      //   top: 40.0,
                      //   left: 16.0,
                      //   child: GestureDetector(
                      //     onTap: () => context.pop(),
                      //     child: const Icon(
                      //       Icons.arrow_back_ios,
                      //       color: Constants.lightGreen,
                      //       size: 28.0,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // workshop details
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name and audience
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(workshop.title,
                                style: const TextStyle(
                                    color: Constants.textColor,
                                    fontSize: 20,
                                    fontFamily: "Poppins")),
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
                        // category and organizer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(workshop.organizer.image),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  workshop.organizer.name,
                                  style: const TextStyle(
                                      fontSize: 11, fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                            color: Constants.dividerColor, thickness: 1),
                        // desc
                        const Text("Description"),
                        const SizedBox(height: 5),
                        Text(workshop.description,
                            style: const TextStyle(
                                color: Constants.lightTextColor, fontSize: 14)),
                        const Divider(
                            color: Constants.dividerColor, thickness: 1),
                        // instructor
                        const Text(
                          "Instructor",
                        ),
                        BlocBuilder<BookingBloc, BookingState>(
                          builder: (context, state) {
                            if (state is ChangeQuantityState) {
                              if (state.specific != null) {
                                specific = state.specific!;
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
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
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        specific.instructorDescription,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Constants.lightTextColor),
                                      ),
                                    ]);
                              }
                            }
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                            specific.instructorImage,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(specific.instructorName,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    specific.instructorDescription,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Constants.lightTextColor),
                                  ),
                                ]);
                          },
                        ),
                        const Divider(
                          color: Constants.dividerColor,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Available Days",
                            ),
                            organizer != null
                                ? TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Constants.lightOrange)),
                                    onPressed: () => context.push(
                                            screen: AddWorkshopScreen(
                                          isSingleWorkShope: true,
                                          workshop: specific,
                                        )),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.add),
                                        Text("Add day"),
                                      ],
                                    ))
                                : const Text("")
                          ],
                        ),
                        const SizedBox(height: 10),
                        DateRadioButton(
                          workshop: workshop.workshops,
                          selectedDate: selectedDate,
                          onTap: (chosenDay) {
                            selectedDate = chosenDay.split(' ')[1];
                            bloc.add(UpdateDayEvent(
                            selectedDate: chosenDay.split(' ')[1],
                            specific: workshop.workshops
                                .where((workshop) => workshop.date
                                    .contains(selectedDate))
                                .toList()
                                .last,
                          ));
                          log(selectedDate);
                          }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // available seats
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
                        // location
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
                            // venue name and type
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
                        // map "if exist"
                        BlocBuilder<BookingBloc, BookingState>(
                          builder: (context, state) {
                            if (state is ChangeQuantityState) {
                              if (state.specific != null) {
                                specific = state.specific!;
                                return state.specific!.isOnline ||
                                        state.specific?.latitude == null ||
                                        state.specific!.latitude!.isEmpty
                                    ? const SizedBox.shrink()
                                    : Stack(children: [
                                        SizedBox(
                                          height:
                                              context.getHeight(divideBy: 3),
                                          width: context.getWidth(),
                                          child: UserMap(
                                            lat: double.parse(
                                                specific.latitude!),
                                            lng: double.parse(
                                                specific.longitude!),
                                          ),
                                        ),
                                        Positioned(
                                                                                    bottom: 7,

                                          left: 10,
                                            child: MainButton(
                                                onPressed: () async {
                                                  final Uri url = Uri.parse(
                                                    'https://www.google.com/maps/search/?api=1&query=${specific.latitude},${specific.longitude}');
                                                  if (!await launchUrl(url)) {
                                                    throw Exception(
                                                        'Could not launch $url');
                                                  }
                                                },
                                                fontSize: 12,
                                                text: "Open in google maps"))
                                      ]);
                              }
                            }
                            return specific.isOnline ||
                                    specific.latitude == null ||
                                    specific.latitude!.isEmpty
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: context.getHeight(divideBy: 4),
                                    width: context.getWidth(),
                                    child: UserMap(
                                      lat: double.parse(specific.latitude!),
                                      lng: double.parse(specific.longitude!),
                                    ),
                                  );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // scan for organizers "if exist"
                        organizer != null
                            ? (specific.isOnline == true ||
                                    DateTime.now()
                                        .isAfter(DateTime.parse(specific.date)))
                                ? const SizedBox.shrink()
                                : MainButton(
                                    text: "Scan Now",
                                    width: context.getWidth(),
                                    onPressed: () async {
                                      var result = await BarcodeScanner
                                          .scan(); //barcode scanner
                                      log(result.type
                                          .toString()); // The result type (barcode, cancelled, failed)	   print(result.rawContent); // The barcode content
                                      log(result.format
                                          .toString()); // The barcode format (as enum)
                                      log(result.rawContent);
                                      final response = await GetIt.I
                                          .get<SupabaseLayer>()
                                          .supabase
                                          .from('booking')
                                          .update({'is_attended': true}).match({
                                        'workshop_id': specific.workshopId,
                                        'qr_code': result.rawContent,
                                        'is_attended': false
                                      }).select();
                                      if (response.isNotEmpty) {
                                        log(response.first.toString());
                                        final booking = BookingModel.fromJson(
                                            response.first);
                                        showModalBottomSheet(
                                            backgroundColor:
                                                Constants.ticketCardColor,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: TicketCard(
                                                    workshopGroup: workshop,
                                                    booking: booking,
                                                    workshop: specific),
                                              );
                                            });
                                      } else {
                                        log("Error: No response from Supabase.");
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ErrorDialog(
                                                    msg: "Invalid qr code"));
                                      }
                                    })
                            // pay for users
                            : BlocBuilder<BookingBloc, BookingState>(
                                builder: (context, state) {
                                  if (state is ChangeQuantityState) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // plus or minus
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
                                                    color:
                                                        Constants.mainOrange)),
                                            Text("${state.quantity}"),
                                            IconButton(
                                                onPressed: () {
                                                  bloc.add(
                                                      ReduceQuantityEvent());
                                                  log(bloc.quantity.toString());
                                                },
                                                icon: const HugeIcon(
                                                    icon: HugeIcons
                                                        .strokeRoundedMinusSignSquare,
                                                    color:
                                                        Constants.mainOrange))
                                          ],
                                        ),
                                        // pay button with moyasar
                                        MainButton(
                                          text:
                                              "Pay ${specific.price * state.quantity} SR",
                                          onPressed: () => showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(24),
                                                width: context.getWidth(),
                                                height: context.getHeight(
                                                    divideBy: 1.35),
                                                decoration: const BoxDecoration(
                                                  color:
                                                      Constants.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              20)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    const Text("Fill Card Info",
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    Theme(
                                                      data: ThemeData(
                                                          textTheme:
                                                              const TextTheme()),
                                                      child: CreditCard(
                                                        config: PaymentConfig(
                                                          creditCard:
                                                              CreditCardConfig(
                                                                  saveCard:
                                                                      false,
                                                                  manual:
                                                                      false),
                                                          publishableApiKey:
                                                              dotenv.env[
                                                                  'MOYASAR_KEY']!,
                                                          amount: ((specific
                                                                      .price *
                                                                  bloc.quantity *
                                                                  100))
                                                              .toInt(),
                                                          description:
                                                              "description",
                                                        ),
                                                        onPaymentResult:
                                                            (PaymentResponse
                                                                result) async {
                                                          if (result.status ==
                                                              PaymentStatus
                                                                  .paid) {
                                                            log("Payment is donnee ${result.status}");
                                                            bloc.add(SaveBookingEvent(
                                                              group: workshop,
                                                                workshop: bloc
                                                                        .chosenWorkshop ??
                                                                    workshop
                                                                        .workshops
                                                                        .first,
                                                                quantity: bloc
                                                                      .quantity));                                                            
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
                                  // pay for users
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // plus or minus
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
                                      // pay button with moyasar
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
                                              height: context.getHeight(
                                                  divideBy: 1.35),
                                              decoration: const BoxDecoration(
                                                color:
                                                    Constants.backgroundColor,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),
                                              ),
                                              child: Column(
                                                children: [
                                                  const Text("Fill Card Info",
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  Theme(
                                                    data: ThemeData(
                                                        textTheme:
                                                            const TextTheme()),
                                                    child: CreditCard(
                                                      config: PaymentConfig(
                                                        creditCard:
                                                            CreditCardConfig(
                                                                saveCard: false,
                                                                manual: false),
                                                        publishableApiKey:
                                                            dotenv.env[
                                                                'MOYASAR_KEY']!,
                                                        amount: ((specific
                                                                    .price *
                                                                bloc.quantity *
                                                                100))
                                                            .toInt(),
                                                        description:
                                                            "description",
                                                      ),
                                                      onPaymentResult:
                                                          (PaymentResponse
                                                              result) async {
                                                        if (result.status ==
                                                            PaymentStatus
                                                                .paid) {
                                                          log("Payment is donnee ${result.status}");
                                                          bloc.add(
                                                              SaveBookingEvent(
                                                                group: workshop,
                                                            workshop: bloc
                                                                    .chosenWorkshop ??
                                                                workshop
                                                                    .workshops
                                                                    .first,
                                                            quantity:
                                                                bloc.quantity,
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
