import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uplant/models/comment_model.dart';
import 'package:uplant/models/project_model.dart';
import 'package:uplant/services/firestore_service.dart';

import 'project_conroller.dart';

class ProjectView extends GetView<ProjectController> {
  ProjectModel project;
  ProjectView({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          project.title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("created by: " + project.ownerName),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat.yMMMd().add_jm().format(project.createdOn.toDate()),
              ),
            ),
            Uri.tryParse(project.imageURL)!.hasAbsolutePath
                ? Image.network(
                    project.imageURL,
                    height: 200,
                  )
                : Container(),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(15.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: Text(project.infoText),
            ),
            for (var comment in project.comments)
              Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(comment.comment),
                        leading: const Icon(Icons.comment),
                        subtitle: Text(
                          "comment from: " +
                              comment.ownerName +
                              "\n" +
                              DateFormat.yMMMd()
                                  .add_jm()
                                  .format(comment.createdOn.toDate()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final nameController = TextEditingController();
          final textController = TextEditingController();

          final _formKey = GlobalKey<FormState>();
          Get.bottomSheet(Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Wrap(
                runSpacing: 10,
                children: [
                  const Text('Comment'),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Enter a Comment',
                      border: OutlineInputBorder(),
                    ),
                    controller: textController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a comment!';
                      }
                      return null;
                    },
                  ),
                  const Text('Your name'),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name!';
                      }
                      return null;
                    },
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseService.addCommentProject(
                            project,
                            CommentModel(
                              createdOn: Timestamp.now(),
                              ownerName: nameController.text,
                              comment: textController.text,
                            ));
                        Get.back();
                        Get.back();
                        Get.to(() => ProjectView(project: project));
                      },
                      child: const Text("Add comment"),
                    ),
                  ),
                ],
              ),
            ),
          ));
        },
        label: const Text('add comment'),
        icon: const Icon(Icons.comment),
      ),
    );
  }
}
