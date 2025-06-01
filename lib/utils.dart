String? trim(String? value) {
  if (value?.trim().isEmpty ?? true) return null;
  return value?.trim();
}
