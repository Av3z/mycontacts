import 'package:flutter/material.dart';
import 'package:mycontacts/src/models/contact_model.dart';
import 'package:mycontacts/src/pages/home_page.dart';
import 'package:mycontacts/src/repositories/contact_repository.dart';
import 'package:mycontacts/src/services/image_service.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  late String pathImage;
  ImageService imageService = ImageService();
  ContactRepository contactRepository = ContactRepository();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Cadastrar"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nome'),
              TextField(
                controller: nameController,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Numero'),
              TextField(
                keyboardType: TextInputType.phone,
                controller: numberController,
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .colorScheme
                                .inversePrimary, // ou inversePrimary, dependendo da sua necessidade
                          ),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)))),
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                      label: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Tire uma foto',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('ou'),
                    ),
                    OutlinedButton.icon(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)))),
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Selecione um arquivo'),
                      onPressed: () async {
                        await imageService
                            .getImg()
                            .then((value) => pathImage = value.toString());
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context)
                                  .colorScheme
                                  .inversePrimary, // ou inversePrimary, dependendo da sua necessidade
                            ),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)))),
                        onPressed: () async {
                          Results newContact = Results(
                            name: nameController.text,
                            number: int.parse(numberController
                                .text), // Certifique-se de converter para int se o número for armazenado como int
                            imagePath: pathImage,
                          );
                          ContactModel contactModel =
                              ContactModel(results: [newContact]);

                          await contactRepository.createContact(contactModel);

                          // ignore: use_build_context_synchronously
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const HomePage();
                            },
                          ));
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Cadastrar',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
