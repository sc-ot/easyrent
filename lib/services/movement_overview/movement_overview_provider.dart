import 'dart:async';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/contract.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/movement_overview.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovementOverviewProvider extends StateProvider {
  StreamSubscription? movementProtocolSubscription;
  MovementOverview movementOverview;
  EasyRentRepository easyRentRepository = EasyRentRepository();

  late InspectionReport inspectionReport;
  MovementOverviewProvider(this.movementOverview) {
    generateInspectionReport();
  }
  Vehicle get vehicle {
    return movementOverview.plannedMovement != null
        ? movementOverview.plannedMovement!.vehicle
        : movementOverview.vehicle!;
  }

  PlannedMovement? get plannedMovement {
    return movementOverview.plannedMovement != null
        ? movementOverview.plannedMovement
        : null;
  }

  Contract? get contract {
    if (movementOverview.vehicle != null) {
      if (movementOverview.movementType == Constants.MOVEMENT_TYPE_ENTRY) {
        return vehicle.lastMovement?.contract;
      } else {
        return vehicle.currentContract;
      }
    } else {
      return movementOverview.plannedMovement?.contract!;
    }
  }

  String? errorTextDay;
  String? errorTextMonth;
  String? errorTextYear;
  String? errorTextMinute;
  String? errorTextHour;

  Map<String, String> vehicleAppointments = {
    "Übergabedatum": "",
    "Hauptuntersuchung": "",
    "Sicherheitsprüfung": "",
    "Tachoprüfung": "",
    "UVV": "",
  };

  void generateInspectionReport() {
    if (movementOverview.vehicle != null) {
      movementProtocolSubscription = easyRentRepository
          .generateInspectionReport(
            movementOverview.movementType,
            vehicle.id,
            contractId: contract?.id,
            plannedMovementId: plannedMovement?.id,
          )
          .asStream()
          .listen(
        (event) {
          event.fold(
            (failure) {},
            (response) {
              inspectionReport = response as InspectionReport;
              vehicleAppointments["Übergabedatum"] =
                  inspectionReport.reportDate;
              vehicleAppointments["Hauptuntersuchung"] =
                  inspectionReport.nextGeneralInspectionDate;

              vehicleAppointments["Sicherheitsprüfung"] =
                  inspectionReport.nextSecurityInspectionDate;

              vehicleAppointments["Tachoprüfung"] =
                  inspectionReport.nextSpeedoMeterInspectionDate;

              vehicleAppointments["UVV"] =
                  inspectionReport.nextUvvInspectionDate;

              setState(state: STATE.SUCCESS);
            },
          );
        },
      );
    }
  }

  void changeDate(
    String key,
    BuildContext context, {
    bool changeTime = false,
  }) {
    FocusNode focusNode = FocusNode();

    TextEditingController textEditingControllerDay = TextEditingController();
    TextEditingController textEditingControllerMonth = TextEditingController();
    TextEditingController textEditingControllerYear = TextEditingController();
    TextEditingController textEditingControllerMinute = TextEditingController();
    TextEditingController textEditingControllerHour = TextEditingController();

    focusNode.requestFocus();

    String dateString = vehicleAppointments[key]!;
    if (dateString.isNotEmpty) {
      DateTime date = DateTime.parse(dateString);
      textEditingControllerDay.text = date.day.toString();
      textEditingControllerMonth.text = date.month.toString();
      textEditingControllerYear.text = date.year.toString();

      if (changeTime) {
        textEditingControllerMinute.text = date.minute.toString();
        textEditingControllerHour.text = date.hour.toString();
      }
    }

    errorTextDay = null;
    errorTextMonth = null;
    errorTextYear = null;
    errorTextHour = null;
    errorTextMinute = null;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              key,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textEditingControllerDay,
                          onChanged: (value) {
                            if (value.length == 2) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          keyboardType: TextInputType.number,
                          focusNode: focusNode,
                          maxLength: 2,
                          decoration: InputDecoration(
                              counterText: "",
                              labelText: "Tag",
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                              errorText: errorTextDay),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: TextField(
                        controller: textEditingControllerMonth,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 2) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        maxLength: 2,
                        decoration: InputDecoration(
                            counterText: "",
                            labelText: "Monat",
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                            errorText: errorTextMonth),
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: TextField(
                        controller: textEditingControllerYear,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        onChanged: (value) {
                          if (value.length == 4) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                            counterText: "",
                            labelText: "Jahr",
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                            errorText: errorTextYear),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  changeTime
                      ? Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: textEditingControllerHour,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              onChanged: (value) {
                                if (value.length == 2) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                  counterText: "",
                                  labelText: "Stunde",
                                  labelStyle:
                                      Theme.of(context).textTheme.subtitle1,
                                  errorText: errorTextHour),
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: TextField(
                              controller: textEditingControllerMinute,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              onChanged: (value) {
                                if (value.length == 2) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                  counterText: "",
                                  labelText: "Minute",
                                  labelStyle:
                                      Theme.of(context).textTheme.subtitle1,
                                  errorText: errorTextMinute),
                            )),
                          ],
                        )
                      : Container(),
                  changeTime
                      ? SizedBox(
                          height: 16,
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        bool successful = true;
                        if (changeTime) {
                          bool validDate = validateDate(
                            textEditingControllerDay.text,
                            textEditingControllerMonth.text,
                            textEditingControllerYear.text,
                          );

                          bool validTime = validateTime(
                            textEditingControllerHour.text,
                            textEditingControllerMinute.text,
                          );
                          successful = validDate && validTime;
                        } else {
                          successful = validateDate(
                            textEditingControllerDay.text,
                            textEditingControllerMonth.text,
                            textEditingControllerYear.text,
                          );
                        }

                        setState(
                          () {},
                        );
                        if (successful) {
                          if (changeTime) {
                            vehicleAppointments[key] = DateTime(
                              int.parse(textEditingControllerYear.text),
                              int.parse(textEditingControllerMonth.text),
                              int.parse(textEditingControllerDay.text),
                              int.parse(textEditingControllerHour.text),
                              int.parse(textEditingControllerMinute.text),
                            ).toIso8601String();
                          } else {
                            vehicleAppointments[key] = DateTime(
                              int.parse(textEditingControllerYear.text),
                              int.parse(textEditingControllerMonth.text),
                              int.parse(textEditingControllerDay.text),
                            ).toIso8601String();
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Abspeichern",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  bool validateTime(String hourText, String minuteText) {
    errorTextMinute = null;
    errorTextHour = null;

    bool wrongMinute = false;
    bool wrongHour = false;
    int? hour = int.tryParse(hourText);
    int? minute = int.tryParse(minuteText);

    if (hour == null || hour < 0 || hour > 23) {
      errorTextHour = "Ungültige Stunde";
      wrongMinute = true;
    }

    if (minute == null || minute < 0 || minute > 59) {
      errorTextMinute = "Ungültige Minute";
      wrongMinute = true;
    }

    if (wrongMinute || wrongHour) {
      return false;
    }
    return true;
  }

  bool validateDate(String dayText, String monthText, String yearText) {
    int? day;
    int? month;
    int? year;

    bool wrongDay = false;
    bool wrongMonth = false;
    bool wrongYear = false;

    day = int.tryParse(dayText);
    month = int.tryParse(monthText);
    year = int.tryParse(yearText);

    errorTextDay = null;
    errorTextMonth = null;
    errorTextYear = null;

    if (day == null || day < 1 || day > 31) {
      errorTextDay = "Ungültiger Tag";
      wrongDay = true;
    }
    if (month == null || month < 1 || month > 12) {
      errorTextMonth = "Ungültiger Monat";
      wrongMonth = true;
    }
    if (year == null || year < 1) {
      errorTextYear = "Ungültiges Jahr";
      wrongYear = true;
    }

    if (year != null && year >= 100 && year < 1000) {
      errorTextYear = "Bitte richtiges Format";
      wrongYear = true;
    }

    // 2 stellige Jahreszahl
    if (year != null && year < 100) {
      year += 2000;
    }

    if (wrongDay || wrongMonth || wrongYear) {
      return false;
    }
    // Februar, kein Schaltjahr, Tag darf nicht über 28 sein
    if (month == 2 && day! > 28 && year! % 4 != 0) {
      errorTextDay = "Ungültiges Datum";
      wrongDay = true;
    }
    // Februar, Schaltjahr, Tag darf nicht über 29 sein
    if (month == 2 && day! > 29 && year! % 4 == 0) {
      errorTextDay = "Ungültiges Datum";
      wrongDay = true;
    }
    // Jeder 2 Monat bis Juli darf nicht mehr als 30 Tage haben
    if (month! % 2 == 0 && day! > 30 && month <= 7) {
      errorTextDay = "Ungültiges Datum";
      wrongDay = true;
    }
    // Nach Juli andersum, jeder 2 Monat hat 31 Tage
    if (month % 2 != 0 && day! > 30 && month > 7) {
      errorTextDay = "Ungültiges Datum";
      wrongDay = true;
    }
    if (wrongDay || wrongMonth || wrongYear) {
      return false;
    }

    // SUCCESS
    return true;
  }
}
