String? trim(String? value) {
  if (value?.trim().isEmpty ?? true) return null;
  return value?.trim();
}

String? validateNotEmpty(value, caption) =>
    trim(value) == null ? caption : null;