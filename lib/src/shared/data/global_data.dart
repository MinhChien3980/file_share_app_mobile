class GlobalData {
  static final GlobalData instance = GlobalData.internal();

  factory GlobalData() {
    return instance;
  }
  GlobalData.internal();

  final _memoryData = <String, dynamic>{};

  void setData(String key, dynamic value) {
    _memoryData[key] = value;
  }

  dynamic getData(String key) {
    return _memoryData[key];
  }

  void removeData(String key) {
    _memoryData.remove(key);
  }

  void clear() {
    _memoryData.clear();
  }
}
