import 'package:dio/dio.dart';
import 'package:mycontacts/src/models/contact_model.dart';

class ContactRepository {
  final _dio = Dio();

  final APPLICATION_ID = "dCiMQWnmHuvOwI7fRWfNGWmhh9BRIddn8rC0YEGk";
  final APY_KEY = "7fQa3eXK2IosQP5GZZirsyPMVpYw5Wp3FgU4OjB3";
  final CONTENT_TYPE = "application/json";
  final BASE_URL = "https://parseapi.back4app.com/classes";

  ContactRepository() {
    _dio.options.headers['X-Parse-Application-Id'] = APPLICATION_ID;
    _dio.options.headers['X-Parse-REST-API-Key'] = APY_KEY;
    _dio.options.headers['Content-Type'] = CONTENT_TYPE;
    _dio.options.baseUrl = BASE_URL;
  }

  Future<ContactModel> getContact() async {
    var result = await _dio.get("/contacts");
    return ContactModel.fromJson(result.data);
  }

  Future<void> createContact(ContactModel contactModel) async {
    var result = contactModel.toJson();
    await _dio.post("/contacts", data: result['results'][0]);
  }
}
