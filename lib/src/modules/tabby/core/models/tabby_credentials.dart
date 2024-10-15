class TabbyCredential {
  /// Tabby `publishable secret key` provided by Tabby to process the payments
  late String psKey;

  /// Merchant code for Tabby, default is `sa` for Saudi Arabia
  late String merchantCode;

  /// Tabby `secret key` provided by Tabby to process the payments, only needed for `get`, `capture`, and `refund` operations
  late String secretKey;

  /// Tabby credentials to process the payments
  TabbyCredential({
    required this.psKey,
    this.merchantCode = "sa",
    this.secretKey = "",
  });

  /// Convert the TabbyCredential to JSON
  Map<String, dynamic> toJson() => {
        'psKey': psKey,
        'merchantCode': merchantCode,
        'secretKey': secretKey,
      };

  /// End-point Header
  Map<String, String> get tabbyHeaders => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $secretKey',
      };
}
