// coverage:ignore-file
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ai_avatar_explorer_app/data/end_points.dart';
import 'package:ai_avatar_explorer_app/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart' as media_type;

import '../utilts/utils.dart';

/// API WRAPPER to call all the APIs and handle the error status codes
class ApiWrapper {
  /// Method to make all the requests inside the app like GET, POST, PUT, Delete
  Future<ResponseModel> makeRequest(
    String url,
    Request request,
    dynamic data,
    bool isLoading,
    Map<String, String> headers, {
    media_type.MediaType? mediaType,
    List<ImageFormData>? mediaFileList,
  }) async {
    /// To see whether the network is available or not
    if (await Utility.isNetworkAvailable()) {
      switch (request) {
        /// Method to make the Get type request
        case Request.get:
          {
            var uri = EndPoints.baseUrl + url;

            if (isLoading) {
              // showDialog(context: context, builder: builder)
              // Utility.showLoader();
            }

            try {
              final response = await http
                  .get(Uri.parse(uri), headers: headers)
                  .timeout(const Duration(seconds: 120));

              // //if (isLoading) Utility.closeDialog();
              var res = returnResponse(response);
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              // Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }
        case Request.post:

          /// Method to make the Post type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                // if (Get.isSnackbarOpen) {
                //   await Get.closeCurrentSnackbar();
                // }
                // Utility.showLoader();
              }
              final response = await http
                  .post(
                    Uri.parse(uri),
                    body: jsonEncode(data),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 120));

              // //if (isLoading) Utility.closeDialog();

              var res = returnResponse(response);
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              // Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }
        case Request.put:

          /// Method to make the Put type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                // if (Get.isSnackbarOpen) {
                //   await Get.closeCurrentSnackbar();
                // }
                // Utility.showLoader();
              }
              final response = await http
                  .put(Uri.parse(uri), body: data, headers: headers)
                  .timeout(const Duration(seconds: 120));

              // //if (isLoading) Utility.closeDialog();

              var res = returnResponse(response);
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              // //if (isLoading) Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }

        case Request.patch:

          /// Method to make the Patch type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                // if (Get.isSnackbarOpen) {
                //   await Get.closeCurrentSnackbar();
                // }
                // Utility.showLoader();
              }
              final response = await http
                  .patch(
                    Uri.parse(uri),
                    body: jsonEncode(data),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 120));

              // //if (isLoading) Utility.closeDialog();

              var res = returnResponse(response);
              log(
                'URL :- $uri\nData :- $data\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}\nHeaders :- $headers',
              );
              return res;
            } on TimeoutException catch (_) {
              // //if (isLoading) Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
                statusCode: 1000,
              );
            }
          }
        case Request.delete:

          /// Method to make the Delete type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                // if (Get.isSnackbarOpen) {
                //   await Get.closeCurrentSnackbar();
                // }
                // Utility.showLoader();
              }
              final response = await http
                  .delete(
                    Uri.parse(uri),
                    body: jsonEncode(data),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 120));

              // //if (isLoading) Utility.closeDialog();

              var res = returnResponse(response);
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              // //if (isLoading) Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }
        case Request.awsUpload:

          /// Method to make the Put type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                // if (Get.isSnackbarOpen) {
                //   await Get.closeCurrentSnackbar();
                // }
                // Utility.showLoader();
              }
              var request = http.MultipartRequest('POST', Uri.parse(uri));
              request.files.add(
                await http.MultipartFile.fromPath(
                  'file',
                  data ?? '',
                  contentType:
                      mediaType ?? media_type.MediaType("image", "jpeg"),
                ),
              );
              request.headers.addAll(headers);

              http.StreamedResponse response = await request.send().timeout(
                const Duration(seconds: 120),
              );
              // //if (isLoading) Utility.closeDialog();
              var bytesToString = await response.stream.bytesToString();
              var res = ResponseModel(
                data: bytesToString,
                hasError: false,
                statusCode: 200,
              );
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              // //if (isLoading) Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }
        case Request.awsFileUpload:

          /// Method to make the Put type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                //if (Get.isSnackbarOpen) {
                //                 await //Get.closeCurrentSnackbar//();
                //                }
                //               //Utility.showLoader();
              }
              var request = http.MultipartRequest('POST', Uri.parse(uri));
              request.files.add(
                await http.MultipartFile.fromPath(
                  'file',
                  data ?? '',
                  contentType:
                      mediaType ?? media_type.MediaType("application", "pdf"),
                ),
              );
              request.headers.addAll(headers);

              http.StreamedResponse response = await request.send().timeout(
                const Duration(seconds: 120),
              );
              //if (isLoading) Utility.closeDialog();
              var bytesToString = await response.stream.bytesToString();
              var res = ResponseModel(
                data: bytesToString,
                hasError: false,
                statusCode: 200,
              );
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              //if (isLoading) Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }
        case Request.getApiWithoutBaseURL:
          {
            if (isLoading) {
              //if (Get.isSnackbarOpen) {
              //                 await //Get.closeCurrentSnackbar//();
              //                }
              //               //Utility.showLoader();
            }

            try {
              final response = await http
                  .get(Uri.parse(url), headers: headers)
                  .timeout(const Duration(seconds: 120));

              //if (isLoading) Utility.closeDialog();

              var res = returnResponse(response);
              log(
                'URL :- $url\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              // Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }
        case Request.postWithFormData:

          /// Method to make the Put type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                //if (Get.isSnackbarOpen) {
                //                 await //Get.closeCurrentSnackbar//();
                //                }
                //               //Utility.showLoader();
              }
              var request = http.MultipartRequest('POST', Uri.parse(uri));
              request.fields.addAll(data);

              for (var fileData in mediaFileList ?? <ImageFormData>[]) {
                request.files.add(
                  await http.MultipartFile.fromPath(
                    fileData.fieldName,
                    fileData.filePath,
                    contentType:
                        fileData.mediaType ??
                        media_type.MediaType("application", "image"),
                  ),
                );
              }

              request.headers.addAll(headers);

              request.fields.addAll(data);

              http.StreamedResponse response = await request.send().timeout(
                const Duration(seconds: 120),
              );
              //if (isLoading) Utility.closeDialog();
              var bytesToString = await response.stream.bytesToString();
              var res = ResponseModel(
                data: bytesToString,
                hasError: false,
                statusCode: 200,
              );
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              //if (isLoading) Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }

        case Request.awsProfileUpload:

          /// Method to make the Put type request
          {
            var uri = EndPoints.baseUrl + url;

            try {
              if (isLoading) {
                //if (Get.isSnackbarOpen) {
                //                 await //Get.closeCurrentSnackbar//();
                //                }
                //               //Utility.showLoader();
              }
              var request = http.MultipartRequest('POST', Uri.parse(uri));
              request.files.add(
                await http.MultipartFile.fromPath(
                  'profile',
                  data ?? '',
                  contentType:
                      mediaType ?? media_type.MediaType("image", "jpeg"),
                ),
              );
              request.headers.addAll(headers);

              http.StreamedResponse response = await request.send().timeout(
                const Duration(seconds: 120),
              );
              //if (isLoading) Utility.closeDialog();
              var bytesToString = await response.stream.bytesToString();
              var res = ResponseModel(
                data: bytesToString,
                hasError: false,
                statusCode: 200,
              );
              log(
                'URL :- $uri\nData :- $data\nHeaders :- $headers\nResponse :-\nStatus Code :- ${res.statusCode}\nResponse Data :- ${res.data}',
              );
              return res;
            } on TimeoutException catch (_) {
              //if (isLoading) Utility.closeDialog();
              return ResponseModel(
                data: '{"message":"Request timed out"}',
                hasError: true,
              );
            }
          }
      }
    }
    /// If there is no network available then instead of print can show the no internet widget too
    else {
      return ResponseModel(
        data:
            '{"message":"No internet, please enable mobile data or wi-fi in your phone settings and try again"}',
        hasError: true,
        statusCode: 1000,
      );
    }
  }

  /// Method to return the API response based upon the status code of the server
  ResponseModel returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
      case 205:
      case 208:
        return ResponseModel(
          data: response.body,
          hasError: false,
          statusCode: response.statusCode,
        );
      case 400:
      case 401:

        /// unauthorized
        // Repository(DeviceRepository(), DataRepository(ConnectHelper()))
        //     .deleteAllSecuredValues();

        return ResponseModel(
          data: response.body,
          hasError: true,
          statusCode: response.statusCode,
        );
      case 406:

        /// To hit refresh token
        return ResponseModel(
          data: response.body,
          hasError: true,
          statusCode: response.statusCode,
        );
      case 409:
      case 500:
      case 522:
      case 204:
        return ResponseModel(
          data: response.body,
          hasError: true,
          statusCode: response.statusCode,
        );
      default:
        return ResponseModel(
          data: response.body,
          hasError: true,
          statusCode: response.statusCode,
        );
    }
  }
}
