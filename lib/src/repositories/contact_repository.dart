import 'package:dio/dio.dart';
import 'package:mycontacts/src/models/contact_model.dart';

class ContactRepository {
  Future<ContactModel> getContact() async {
    var dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] = "";
    dio.options.headers['X-Parse-REST-API-Key'] = "";
    var result =
        await dio.get('https://parseapi.back4app.com/classes/contacts');
    return ContactModel.fromJson(result.data);
  }
}
