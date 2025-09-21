import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask(String task) {
    if (task.trim().isEmpty) return;
    setState(() {
      tasks.add(task);
    });
    taskController.clear();
  }

  void editTask(int index, String newTask) {
    if (newTask.trim().isEmpty) return;
    setState(() {
      tasks[index] = newTask;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void showEditDialog(int index) {
    TextEditingController editController = TextEditingController(text: tasks[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Tarefa'),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: InputDecoration(hintText: 'Nova tarefa'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              editTask(index, editController.text);
              Navigator.of(context).pop();
            },
            child: Text('Salvar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Adicionar uma nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => addTask(taskController.text),
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(tasks[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => showEditDialog(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteTask(index),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
