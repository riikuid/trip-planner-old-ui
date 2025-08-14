import 'package:flutter/material.dart';
import 'package:iterasi1/pages/add_activities/suggestion_Itinerary.dart';
import 'package:iterasi1/resource/custom_colors.dart';

import '../../model/activity.dart';

class FormSuggestion extends StatefulWidget {
  final Activity? initialActivity;
  final Function(Activity) onSubmit;

  const FormSuggestion(
      {this.initialActivity, required this.onSubmit, super.key});

  @override
  FormSuggestionState createState() => FormSuggestionState();
}

class FormSuggestionState extends State<FormSuggestion> {
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();
  bool _isEndTimeValid = true;
  bool _isTitleValid = true;
  bool _isLocationValid = true;
  bool _showTitleValidationMessage =
      false; // Variabel kontrol untuk pesan validasi judul
  bool _showLocationValidationMessage =
      false; // Variabel kontrol untuk pesan validasi lokasi

  final TextEditingController titleController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    if (widget.initialActivity != null) {
      titleController.text = widget.initialActivity!.activityName;
      lokasiController.text = widget.initialActivity!.lokasi;
      keteranganController.text = widget.initialActivity!.keterangan;
      _selectedStartTime = widget.initialActivity!.startTimeOfDay;
      print('start time : $_selectedStartTime');
      _selectedEndTime = widget.initialActivity!.endTimeOfDay;
      print('end time : $_selectedEndTime');
      super.initState();
    }
    titleController.addListener(() {
      _validateTitle(showMessage: true);
    });
    lokasiController.addListener(() {
      _validateLocation(showMessage: true);
    });
    _validateTitle();
    _validateLocation();
  }

  void _validateTitle({bool showMessage = false}) {
    setState(() {
      _isTitleValid = titleController.text.trim().isNotEmpty;
      _showTitleValidationMessage = showMessage && !_isTitleValid;
    });
  }

  void _validateLocation({bool showMessage = false}) {
    setState(() {
      _isLocationValid = lokasiController.text.trim().isNotEmpty;
      _showLocationValidationMessage = showMessage && !_isLocationValid;
    });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(
        () {
          _selectedStartTime = picked;
          // _validateEndTime();
        },
      );
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(
        () {
          _selectedEndTime = picked;
          // _validateEndTime();
        },
      );
    }
  }

  // void _validateEndTime() {
  //   setState(
  //     () {
  //       _isEndTimeValid = _selectedEndTime.hour > _selectedStartTime.hour ||
  //           (_selectedEndTime.hour == _selectedStartTime.hour &&
  //               _selectedEndTime.minute > _selectedStartTime.minute);
  //     },
  //   );
  // }

  void _submitActivity() {
    final newActivity = Activity(
      activityName: titleController.text,
      lokasi: lokasiController.text,
      startActivityTime: _selectedStartTime.format(context),
      endActivityTime: _selectedEndTime.format(context),
      keterangan: keteranganController.text,
      removedImages: widget.initialActivity?.removedImages,
    );

    widget.onSubmit(newActivity);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.surface,
      appBar: AppBar(
        backgroundColor: CustomColor.surface,
        title: const Text(
          "Form Rekomendasi",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'poppins_bold',
            fontSize: 30,
            color: CustomColor.buttonColor,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lokasi Berangkat",
                        style: TextStyle(
                          fontFamily: 'poppins_bold',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: _isTitleValid ? Colors.grey : Colors.red,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: _isTitleValid
                                  ? const Color(0xFF305A5A)
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      if (_showTitleValidationMessage)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Lokasi tidak boleh kosong',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lokasi Tujuan",
                        style: TextStyle(
                          fontFamily: 'poppins_bold',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: lokasiController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color:
                                  _isLocationValid ? Colors.grey : Colors.red,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: _isLocationValid
                                  ? const Color(0xFF305A5A)
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                          // suffixIcon: const Icon(
                          //   IconData(0xe055, fontFamily: 'MaterialIcons'),
                          //   size: 30,
                          //   color: Colors.black,
                          // ),
                        ),
                      ),
                      if (_showLocationValidationMessage)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Lokasi tidak boleh kosong',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const Text(
                  //             'Waktu Berangkat',
                  //             style: TextStyle(
                  //               fontFamily: 'poppins_bold',
                  //               fontSize: 19,
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //           const SizedBox(height: 10),
                  //           SizedBox(
                  //             width: double.infinity,
                  //             child: GestureDetector(
                  //               onTap: () => _selectStartTime(context),
                  //               child: Container(
                  //                 width: 145,
                  //                 height: 60,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(12),
                  //                   border: Border.all(
                  //                     color: CustomColor.borderColor,
                  //                     width: 1,
                  //                   ),
                  //                 ),
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(left: 10),
                  //                         child: Text(
                  //                           _selectedStartTime.format(context),
                  //                           style: const TextStyle(
                  //                             fontFamily: 'Poppins',
                  //                             fontSize: 20,
                  //                             color: Colors.black,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 5),
                  //                     const Icon(
                  //                       Icons.access_time,
                  //                       size: 30,
                  //                       color: Colors.black,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     const SizedBox(width: 24),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const Text(
                  //             'Waktu Kembali',
                  //             style: TextStyle(
                  //               fontFamily: 'poppins_bold',
                  //               fontSize: 19,
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //           const SizedBox(height: 10),
                  //           SizedBox(
                  //             width: double.infinity,
                  //             child: GestureDetector(
                  //               onTap: () => _selectEndTime(context),
                  //               child: Container(
                  //                 width: 145,
                  //                 height: 60,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(12),
                  //                   border: Border.all(
                  //                     color: CustomColor.borderColor,
                  //                     width: 1,
                  //                   ),
                  //                 ),
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(left: 10),
                  //                         child: Text(
                  //                           _selectedEndTime.format(context),
                  //                           style: const TextStyle(
                  //                             fontFamily: 'Poppins',
                  //                             fontSize: 20,
                  //                             color: Colors.black,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 5),
                  //                     const Icon(
                  //                       Icons.access_time,
                  //                       size: 30,
                  //                       color: Colors.black,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // if (!_isEndTimeValid)
                  //   const Padding(
                  //     padding: EdgeInsets.only(top: 8.0),
                  //     child: Text(
                  //       'Waktu Selesai tidak boleh mendahului Waktu Mulai!',
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins',
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //   ),
                  // const SizedBox(height: 25),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const Text(
                  //       'Jumlah Peserta Perjalanan',
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins',
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //       // overflow: TextOverflow.ellipsis,
                  //     ),
                  //     const SizedBox(height: 10),
                  //     TextField(
                  //       controller: keteranganController,
                  //       decoration: InputDecoration(
                  //         hintStyle: const TextStyle(fontSize: 16),
                  //         hintText: 'input dalam bentuk',
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //           borderSide: const BorderSide(
                  //             color: Colors.black,
                  //             width: 2,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
            const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _isEndTimeValid && _isTitleValid && _isLocationValid
                              ? CustomColor.buttonColor
                              : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: _isEndTimeValid &&
                            _isTitleValid &&
                            _isLocationValid
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SuggestionItinerary(),
                              ),
                            );
                          }
                        : null, // Tombol tidak bisa ditekan jika kondisi tidak valid
                    child: const Text(
                      'Simpan Aktivitas',
                      style: TextStyle(
                        fontFamily: 'poppins_bold',
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
