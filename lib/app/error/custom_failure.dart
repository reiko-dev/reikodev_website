enum FailureType { internetOff, unknown }

class CustomFailure {
  final FailureType _type;
  CustomFailure(this._type);

  @override
  String toString() {
    return "Failure code ${_type.index}: ${_type.name}";
  }
}
