class MetaDataFile {
  final String url;
  final String name;
  final String type;
  final int size;

  MetaDataFile({
    required this.url,
    required this.name,
    required this.type,
    required this.size,
  });

  @override
  String toString() {
    return 'MetaDataFile(url: $url, name: $name, type: $type, size: $size)';
  }
}
