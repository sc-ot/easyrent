import 'dart:async';

import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/image_upload_group.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_appframework/network/sc_cache_request_handler.dart';
import 'package:sc_appframework/network/sc_network_api.dart';

class ImageLogProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  StreamSubscription? getImageLogSubscription;

  ImageLogProvider() {
    loadImages();
  }

  List<ImageUploadGroup> imageUploadGroups = [];

  @override
  void dispose() {
    getImageLogSubscription?.cancel();
    super.dispose();
  }

  void loadImages() {
    getImageLogSubscription?.cancel();
    setState(state: STATE.LOADING);
    getImageLogSubscription =
        easyRentRepository.getImageLog().asStream().listen(
      (response) {
        response.fold(
          (failure) {
            print("COULDNT GET");
          },
          (success) {
            imageUploadGroups = List<ImageUploadGroup>.from(success);
            imageUploadGroups = imageUploadGroups.toList();
            List<SCCachedRequest> cachedRequests =
                SCNetworkApi().cachedRequests;

            // LOOP OVER ALL CACHED REQUESTS
            cachedRequests.forEach(
              (cachedRequest) {
                //  IMAGE REQUEST
                if (cachedRequest.method == Method.MULTIPART &&
                    cachedRequest.filePayload != null &&
                    cachedRequest.route.contains(SCNetworkApi().baseUrl)) {
                  // LOOP WITH THE CACHED REQUEST OVER ALL IMAGEUPLOADS. NOT FOUND => ADD, ELSE DONT ADD!

                  bool found = false;
                  for (int i = imageUploadGroups.length; i != 0; i--) {
                    if (imageUploadGroups[i - 1].imageUploadGroupProcessId ==
                        int.tryParse(cachedRequest
                            .filePayload!.params["upload_process"] as String)) {
                      found = true;
                      break;
                    }
                  }
                  if (!found) {
                    ImageUploadGroup imageUploadGroup = ImageUploadGroup(
                        cachedRequest.filePayload!.params["created_at"]
                            as String,
                        cachedRequest.filePayload!.params["vin"] as String,
                        0,
                        cachedRequest.filePayload!.params["client"] as String,
                        cachedRequest.filePayload!.params["vehicle_number"] ==
                                ""
                            ? "Neues Fahrzeug"
                            : cachedRequest
                                .filePayload!.params["vehicle_number"]!,
                        int.tryParse(cachedRequest.filePayload!
                            .params["images_count"] as String) as int,
                        int.tryParse(cachedRequest.filePayload!
                            .params["upload_process"] as String) as int);
                    imageUploadGroups.insert(0, imageUploadGroup);
                  }
                }
              },
            );
            setState(state: STATE.SUCCESS);
          },
        );
      },
    );
  }
}
