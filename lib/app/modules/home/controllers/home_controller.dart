import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

class HomeController extends GetxController {
  List<dynamic>? data;
//   Map<String, dynamic>? data;
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  getData() async {
    apiCallStatus = ApiCallStatus.loading;
    update();
    await BaseClient.safeApiCall(
      Constants.companiesApiUrl(),
      RequestType.get,
      onSuccess: (response) {
        data = List.from(response.data);
        // data = response.data;
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
