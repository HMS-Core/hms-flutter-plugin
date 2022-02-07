import 'package:flutter/material.dart';

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

EdgeInsetsGeometry smallAllPadding(BuildContext context) =>
    EdgeInsets.all(getHeight(context) * 0.01);

EdgeInsetsGeometry smallPadding(BuildContext context) =>
    EdgeInsets.only(top: getHeight(context) * 0.15);

/// Strings
const String homeAppbarText = "Hms ML Text Flutter Plugin";
const String bcrAppbarText = "Bank Card Recognition Demo";
const String documentAppbarText = "Document Recognition Demo";
const String formAppbarText = "Form Recognition Demo";
const String gcrAppbarText = "General Card Recognition Demo";
const String icrAppbarText = "ICR Recognition Demo";
const String lensAppbarText = "Lens Recognition Demo";
const String embeddingAppbarText = "Text Embedding Recognition Demo";
const String textAppbarText = "Text Recognition Demo";
const String exceptionText = "Exception";
const String embeddingTextSimilarity =
    "Similarity between words Space and Planets will be shown below";
const String embeddingWordsSimilarity = "Words Similarity";
const String embeddingGetWordsSimilarity = "Get Words Similarity";
const String embeddingGetSimilarWords = "Get Similar Words";
const String embeddingTextSimilar =
    "Similar words for Space will be shown below";
const String startRecognitionText = "Start Recognition";
const String noneText = "None";
const String lensText = "Text value";
const String permissionText = "Permissions granted";
const String resultBoxText = "Result";
const String resultBoxCardText = "Card Text Result";
const String resultBoxTextsDetected = "Texts detected";
const String captureTipTextText = "Hold still, capturing..";
const String captureText = "Capture";
const String spaceText = "Space";
const String planetsText = "Planets";
const String takePictureText = "Take picture";
const String localImageText = "Recognize With Local Image";

const String galleryText = "PICK FROM GALLERY";
const String cameraText = "USE CAMERA";
const String lensInitButton = "INIT";
const String lensStartButton = "START";
const String lensRelaseButton = "RELEASE";

/// String image path
const String userImage = "assets/user.png";
const String bcrImage = "USE CAMERA";

/// Api Keys
const String homeApiKey =
    "CgB6e3x9P33R+B2u+UHaEIK06gxzH883IZxpQc7BvJmmRgx8wl/sJ0bKGjlKNP46oiTtW6eWj4I73PXtjM2lcHhZ";

/// colors
const Color kPrimaryColor = Color.fromRGBO(109, 220, 207, 1);
const Color kGrayColor = Color.fromRGBO(219, 226, 239, 1);
const Color kBlackColor = Color.fromRGBO(0, 0, 0, 1);
const Color kBlueColor = Color.fromRGBO(144, 202, 249, 1);
const Color kGreenColor = Color.fromRGBO(134, 202, 256, 1);
const Color kDangerColor = Color.fromRGBO(236, 70, 70, 1);

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;
  double get highWidthValue => height * 0.8;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}
