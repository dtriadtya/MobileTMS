class Office {
  final String name;
  final String loc;

  Office({required this.name, required this.loc});

  factory Office.fromJson(Map<String, dynamic> json){
    return Office(
      name: json['name'],
      loc: json['loc']
    );
  }
}