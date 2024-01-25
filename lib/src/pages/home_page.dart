import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mycontacts/src/models/contact_model.dart';
import 'package:mycontacts/src/pages/register_page.dart';
import 'package:mycontacts/src/repositories/contact_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Results>?
      contacts; // Alterado para List<Results> ao invés de List<ContactModel>
  ContactRepository contactRepository = ContactRepository();

  Future<void> loadContacts() async {
    ContactModel contactModel = await contactRepository.getContact();
    setState(() {
      contacts = contactModel.results; // Atribuir a lista de contatos
    });
  }

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Lista de Contatos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return RegisterPage();
            },
          ));
        },
        child: const Icon(Icons.phone_sharp),
      ),
      body: contacts != null
          ? ListView.builder(
              itemCount: contacts!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundImage:
                          FileImage(File(contacts![index].imagePath!)),
                    ),
                    title: Text(contacts![index].name!),
                    subtitle: Text(contacts![index].number.toString()),
                    trailing: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    // Adicione outros widgets conforme necessário para exibir informações do contato
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
