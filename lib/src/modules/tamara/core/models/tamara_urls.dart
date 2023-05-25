class TamaraUrls {
  final String checkoutUrl;
  final String successUrl;
  final String failedUrl;
  final String cancelUrl;
  final bool authoriseOrder;
  final bool captureOrder;

  TamaraUrls({
    required this.checkoutUrl,
    required this.successUrl,
    required this.failedUrl,
    required this.cancelUrl,
    this.authoriseOrder = true,
    this.captureOrder = false,
  });
}
