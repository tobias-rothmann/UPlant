import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplant/models/project_model.dart';
import 'package:uplant/services/firestore_service.dart';

import 'add_project_controller.dart';

class AddProjectView extends GetView<AddProjectController> {
  AddProjectView({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final textController = TextEditingController();
  final imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'add project',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                const Text('Title'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter a Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Your name'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Description'),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter a text',
                    border: OutlineInputBorder(),
                  ),
                  controller: textController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a text!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Image URL'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter a image url',
                    border: OutlineInputBorder(),
                  ),
                  controller: imageController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a image url!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseService.addProject(ProjectModel(
                          title: titleController.text,
                          ownerName: nameController.text,
                          infoText: textController.text,
                          imageURL: imageController.text,
                          comments: []));
                      Get.back();
                    }
                  },
                  child: Text("Add project"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
