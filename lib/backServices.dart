import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:myhabit/addTime.dart';
import 'package:myhabit/notify.dart';
import 'package:myhabit/selectedhabit.dart';

// late final localnotification service2=localnotification();
SelectedHabitData sh = SelectedHabitData();

Future? data;
int x = 0;
localnotification service2 = localnotification();

void check() async {
  print("Time:");
  service2.initlize();
  List d = [];
  d.addAll(await sh.getData());
  for (int i = 0; i < d.length; i++) {
    print("DDD: ${d[i]['time']}");
    String tim1 = '${d[i]['time']}';
    if (tim1 == TimeOfDay.now().toString() ) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => E(),));
      FlutterBackgroundService().invoke('setAsForeground');
      await service2.showNotification(
          id: 1,
          title: "${d[i]['title']} Habit",
          body: "Sustained effort is what makes the real difference",
          second: 10);
      print("ggg");
      x = 1;
    } else {
      // x = 0;
      print("dddd $tim1");
      // print("title ${ss}");
    }
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
      iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: onIosBackground),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));
}

@pragma('vm:entry-point')
FutureOr<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "Hbaits App", content: "running....");
      }
    }
    x = 0;
    check();

    print("background running");
    service.invoke('update');
  });
}
