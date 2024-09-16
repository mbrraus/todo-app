import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_todo/model/todo.dart';

const TODO_COLLECTION_REF = 'todos';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Todo> _todosRef;

  DatabaseService() {
    _todosRef = _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
          fromFirestore: (snapshot, _) => Todo.fromMap(snapshot.data()!),
          toFirestore: (todo, _) => todo.toMap(),
        );
  }

  Stream<QuerySnapshot<Todo>> getTodos() {
    return _todosRef.snapshots();
  }

  Future<void> updateTodo(Todo todo) async {
    QuerySnapshot querySnapshot =
        await _todosRef.where('id', isEqualTo: todo.id).get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      await _todosRef.doc(docId).update(todo.toMap());
    }
  }

  Future<void> addTodo(Todo todo) async {
    await _todosRef.add(todo);
  }

  Future<void> deleteTodo(String todoId) async {
    QuerySnapshot querySnapshot =
        await _todosRef.where('id', isEqualTo: todoId).get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      await _todosRef.doc(docId).delete();
    }
  }
}
