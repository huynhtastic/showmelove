String requiredValidator(String val) {
  if (val.isEmpty) {
    return 'A name is required';
  }

  return null;
}
