import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final CollectionReference _todos =
  FirebaseFirestore.instance.collection('todo');
  // Functions used for adding and editing
  Future<void> _add_or_update([DocumentSnapshot? documentSnapshot]) async {
    String mode = 'addition';
    if (documentSnapshot != null) {
      mode = 'update';
      _todoController.text = documentSnapshot['todo'];
      _contentController.text = documentSnapshot['content'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _todoController,
                  decoration: const InputDecoration(labelText: 'ToDo'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(mode== 'addition' ? 'Add' : 'Update'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final String? todo = _todoController.text;
                    final String? content = _contentController.text;
                    // Addiing process
                    if (todo != null && content != null) {
                      if (mode == 'addition') {
                        // Persist a new product to Firestore
                        await _todos.add({"todo": todo, "content": content});

                        // スナックバー
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Added ${todo}!',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                            )));
                      }
                      // Editing process
                      if (mode == 'update') {
                        // Update the product
                        await _todos
                            .doc(documentSnapshot!.id)
                            .update({"todo": todo, "content": content});

                        // Show the snack bar for the edit
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Updated Content!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white, backgroundColor: Colors.yellowAccent),
                            )));

                      }
                      // Clear the text fields
                      _todoController.text = '';
                      _contentController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deletion Processing Functions
  Future<void> _deleteProduct(String productId) async {
    await _todos.doc(productId).delete();

    // Show the snack bar for the exclusion
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Deleted Content!',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo App'),
          backgroundColor: Colors.red,
        ),
        // StreamBuilder to pass Firestore values to ListView.builder
        body: StreamBuilder(
          stream: _todos.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              // Display FireStore values in list format
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  // View documents in the card widget
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['todo']), // ToDo
                      subtitle: Text(documentSnapshot['content'].toString()), // Content
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // Edit Button
                            IconButton(
                                color: Colors.red,
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _add_or_update(documentSnapshot)),
                            // Delete Button
                            IconButton(
                                color: Colors.red,
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteProduct(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        // Add Button
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => _add_or_update(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
