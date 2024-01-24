import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<String?> getImg() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  Future<String?> getCam() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      try {
        String path = (await getApplicationDocumentsDirectory()).path;
        String namePath = basename(photo.path);
        await photo.saveTo("$path/$namePath");
        await GallerySaver.saveImage(photo.path);

        return photo.path;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
