import 'package:dio/dio.dart';
import 'package:mycontacts/src/models/contact_model.dart';

class ContactRepository {
  Future<ContactModel> getContact() async {
    var dio = Dio();
    var result =
        await dio.get('https://parseapi.back4app.com/classes/contacts');
    return ContactModel.fromJson(result.data);
  }
}
