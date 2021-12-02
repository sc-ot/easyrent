import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/image_upload_group.dart';
import 'package:easyrent/network/repository.dart';

class ImageLogProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();

  ImageLogProvider() {
    loadImages();
  }

  List<ImageUploadGroup> imageUploadGroups = [];

  void loadImages() {
    setState(state: STATE.LOADING);
    easyRentRepository.getImageLog().asStream().listen(
      (response) {
        response.fold(
          (failure) {},
          (success) {
            imageUploadGroups = List<ImageUploadGroup>.from(success);
            setState(state: STATE.SUCCESS);
          },
        );
      },
    );
  }
}
