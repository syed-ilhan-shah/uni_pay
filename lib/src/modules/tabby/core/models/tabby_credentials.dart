class TabbyCredential {
  /// Tabby `publishable secret key` provided by Tabby to process the payments
  late String psKey;

  /// Merchant code for Tabby, default is `sa` for Saudi Arabia
  late String merchantCode;

  /// Tabby credentials to process the payments
  TabbyCredential({
    required this.psKey,
    this.merchantCode = "sa",
  });
}
