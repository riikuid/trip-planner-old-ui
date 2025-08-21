import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/pages/activity_photo_page.dart';
import 'package:iterasi1/pages/add_activities/add_activities.dart';
import 'package:iterasi1/provider/itinerary_provider.dart';
import 'package:iterasi1/resource/custom_colors.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityCard extends StatelessWidget {
  final Activity data;
  final int selectedDayIndex;
  final int activityIndex;
  final void Function() onDismiss;
  final void Function() onUndo;
  final ScaffoldMessengerState snackbarHandler;
  const ActivityCard({
    super.key,
    required this.data,
    required this.selectedDayIndex,
    required this.activityIndex,
    required this.onDismiss,
    required this.onUndo,
    required this.snackbarHandler,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> requestGalleryPermission(Activity activity) async {
      var result = await PhotoManager
          .requestPermissionExtend(); // Langsung meminta permission dan mendapatkan hasilnya
      if (result.isAuth) {
        // Jika izin diberikan, navigasi ke ActivityPhotoPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityPhotoPage(
                dayIndex: selectedDayIndex,
                activity:
                    activity), // Pastikan class ActivityPhotoPage menerima parameter activity
          ),
        );
      } else {
        // Tampilkan dialog jika izin tidak diberikan
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Perizinan Ditolak"),
            content:
                const Text("Aplikasi memerlukan izin untuk mengakses galeri."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }

    Future<void> openGoogleMaps(String placeName) async {
      // Encode nama tempat untuk URL
      String query = Uri.encodeComponent(placeName);
      String googleMapsUrl =
          "https://www.google.com/maps/search/?api=1&query=$query";

      final Uri url = Uri.parse(googleMapsUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    final currentActivity = data.copy();

    return Dismissible(
      onDismissed: (DismissDirection direction) {
        snackbarHandler.removeCurrentSnackBar();
        onDismiss();

        snackbarHandler.showSnackBar(
          SnackBar(
            content: const Text("Item dihapus!"),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                onUndo();
                snackbarHandler.removeCurrentSnackBar();
              },
            ),
          ),
        );
      },
      key: Key(data.hashCode.toString()),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              log("removed images" + data.removedImages.toString());
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddActivities(
                      initialActivity: data,
                      onSubmit: (newActivity) {
                        context.read<ItineraryProvider>().updateActivity(
                            updatedDayIndex: selectedDayIndex,
                            updatedActivityIndex: activityIndex,
                            newActivity: newActivity);
                      },
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: CustomColor.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.activityName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'poppins_bold',
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        IconData(0xe055,
                                            fontFamily: 'MaterialIcons'),
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 9,
                                      ),
                                      Expanded(
                                        child: Text(
                                          data.lokasi,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontFamily: 'poppins_bold',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 9,
                                      ),
                                      Text(
                                        "${data.startActivityTime} - ${data.endActivityTime}",
                                        style: const TextStyle(
                                          fontFamily: 'poppins_bold',
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                data.keterangan,
                                style: const TextStyle(
                                  fontFamily: 'poppins_regular',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                onTap: () {
                                  print('activity:${data.startDateTime}');
                                  print('activity:${data.startActivityTime}');
                                  requestGalleryPermission(
                                      data); // Kirim activity sebagai argument
                                },
                                child: Icon(
                                  Icons.photo_library_rounded,
                                  color: CustomColor.surface,
                                  size: 30,
                                ),
                              ),
                            ),
                            if (!data.isCustomLocation)
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: InkWell(
                                  onTap: () {
                                    openGoogleMaps(data.lokasi);
                                  },
                                  child: Icon(
                                    Icons.location_on,
                                    color: CustomColor.surface,
                                    size: 30,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
