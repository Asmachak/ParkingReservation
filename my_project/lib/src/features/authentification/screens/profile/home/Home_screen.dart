import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/src/features/authentification/models/parking.dart';
import 'package:my_project/src/features/authentification/screens/profile/home/details_parking.dart';
import '../../../controllers/parkingController.dart';

final parkingDataProvider = FutureProvider<Parking?>((ref) async {
  return ref.watch(parkingControllerProvider).getParkings();
});

class HomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Les Parking disponibles',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ProviderScope(
              child: Consumer(
                builder: (context, ref, _) {
                  final parkingsAsyncValue = ref.watch(parkingDataProvider);
                  return parkingsAsyncValue.when(
                    data: (parkings) {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: parkings?.listeDesParking?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final parking = parkings!.listeDesParking![index];
                          final imageUrl = parking.imageParking ?? 'https://example.com/defaultImage.jpg';

                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                final selectedParking = parkings?.listeDesParking?[index]; // Extract the selected parking
                                if (selectedParking != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsParking(parking: selectedParking),
                                    ),
                                  );
                                }
                              },

                              child: Container(
                                height: 110,
                                width: 320,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      offset: Offset(-1, 1),
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            child: Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    parking.nomParking ?? '',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Row(
                                              children: [],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 3),
                                                Text(
                                                  parking.tarifPlace?.toString() ?? '',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                Text(
                                                  "Euro/heure",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1, // Adjust the flex value as needed
                                      child: Center(
                                        child: Text(
                                          "4KM",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => Container(),
                    error: (error, stackTrace) => Text('Error fetching parkings: $error'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
