class Constants {
  // Base URL
  static const baseUrl = 'https://fake-api.tractian.com/';

  // Endpoints
  static String companiesApiUrl() => '${baseUrl}companies';
  static String locationsApiUrl(String companyId) =>
      '${baseUrl}companies/$companyId/locations';
  static String assetsApiUrl(String companyId) =>
      '${baseUrl}companies/$companyId/assets';

  // Images
  static const logo = 'assets/images/app_icon.png';
  static const noData = 'assets/images/no_data.png';
  static const box = 'assets/images/icon.svg';
  static const ioCubeOutline = 'assets/images/IoCubeOutline.svg';
  static const codepen = 'assets/images/Codepen.png';
}
