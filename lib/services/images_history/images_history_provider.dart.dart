import 'package:devtools/storage.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';

class ImagesHistoryProvider extends StateProvider {
  Storage storage = Storage();
  ImagesHistoryProvider();

   void loadImages()  {

    String? result = storage.sharedPreferences.getString(Constants.KEY_IMAGES);
    if(result != null){
      
    }
  }
}
