final String myListsTableName = 'my_lists';

class MyListsTableFields {
  static final List<String> values = [id, name];

  static final String id = 'id';
  static final String name = 'name';
}

class MyLists {
  final int? id;
  final String? name;

  const MyLists({this.id, this.name});

  MyLists copy({int? id, String? name}) {
    // this copy method's return type is Lists
    return MyLists(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, Object?> toJson() => {
        // converting the object to json
        // this method's return type is Map
        MyListsTableFields.id: id,
        MyListsTableFields.name: name
      };

  static MyLists fromJson(Map<String, Object?> json) => MyLists(
        // converting the json to MyLists object
        id: json[MyListsTableFields.id] as int?,
        name: json[MyListsTableFields.name] as String?,
      );
}
