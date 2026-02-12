mixin EqualsMixin {
  List<Object?> get fields;
  
  @override
  bool operator == (Object other){
    return identical(this, other)||
      other is EqualsMixin && runtimeType == other.runtimeType && _areListEqual(fields, other.fields);
  }


  @override
  int get hashCode {
    return runtimeType.hashCode ^ _combineHashCodes(fields);
  }

  bool _areListEqual(List<Object?> a, List<Object?> b){
    if (a.length != b.length) return false; 
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }  
    return true;
  }


  int _combineHashCodes(List<Object?> objects){
    return objects.fold(
      0,
      (hash, object)=> hash ^ (object?.hashCode ?? 0),
    );
  }
}