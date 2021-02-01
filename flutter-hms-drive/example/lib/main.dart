/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:huawei_drive/huawei_drive.dart';
import 'custom_widgets/custom_button.dart';
import 'custom_widgets/custom_console.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String fileId;
  List<String> responsesToDisplay = [];
  String commentId;

  RefreshCallback refreshTokenCallback;
  HmsAuthHuaweiId _id;
  Drive drive;

  void fileIdSnackbar() {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("FileId is empty. Please create a file.")));
  }

  void fileCommentIdSnackbar() {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Either file or comment id is empty. Please create a comment on created file.")));
  }

  final helper = new HmsAuthParamHelper()
    ..setIdToken()
    ..setAccessToken()
    ..setAuthorizationCode()
    ..setEmail()
    ..setScopeList([
      SCOPE_BASE_PROFILE,
      SCOPE_DRIVE,
      SCOPE_DRIVE_FILE,
      SCOPE_DRIVE_READONLY,
      SCOPE_DRIVE_METADATA,
      SCOPE_DRIVE_METADATA_READONLY,
      SCOPE_DRIVE_APPDATA,
    ])
    ..setProfile();

  @override
  void initState() {
    super.initState();
    signIn();
    permissionCheck();
  }

  void permissionCheck() async {
    bool status = await HmsDrivePermissions.hasReadAndWritePermission();
    log(status.toString(), name: "Permission Status");
    setState(() {
      responsesToDisplay.add("Permission Status: $status");
    });
  }

  void requestPermissions() async {
    bool status = await HmsDrivePermissions.requestReadAndWritePermission();
    log(status.toString(), name: "Request Permission State");
    setState(() {
      responsesToDisplay.add("Request Permission State: $status");
    });
  }

  Future<String> refreshToken() async {
    _id = await HmsAuthService.silentSignIn(authParamHelper: helper);
    log('RefreshToken called', name: "FlutterDEMO");
    return _id.accessToken;
  }

  void _onBatchError(Object error) {
    if (error is PlatformException) {
      log("BatchError: ${jsonDecode(error.message)}");
    }
  }

  _onBatchEvent(dynamic event) {
    log(event.toString());
    setState(() {
      responsesToDisplay.add("Batch Operation - Success");
    });
  }

  void signIn() async {
    if (!mounted) return;
    try {
      _id = await HmsAuthService.signIn(authParamHelper: helper);
      String unionId = _id.unionId;
      RefreshTokenCallback refreshTokenCallback = refreshToken;
      DriveCredentials deviceCredentials =
          DriveCredentials(unionId, _id.accessToken, refreshTokenCallback);
      drive = await Drive.init(deviceCredentials);
      print("User: ${_id.displayName}");
    } on Exception catch (e) {
      print(e.toString());
    }
    drive.batch.onBatchResult.listen(_onBatchEvent, onError: _onBatchError);
  }

  void _getAbout() async {
    DriveAbout about = await drive.about(AboutRequest());

    log("About: $about");

    setState(() {
      responsesToDisplay.add("User Display Name: " + about.user.displayName);
    });
  }

  void _createFile() async {
    ByteData byteData = await rootBundle.load("assets/demoImage.jpg");
    Int8List byteArray = byteData.buffer
        .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes);

    DriveFile fileMetadata = DriveFile(
      fileName: "createdFile.jpg",
      mimeType: "image/jpg",
    );

    DriveFileContent fileContent = DriveFileContent(
      type: "image/jpg",
      byteArray: byteArray,
    );

    DriveFile createdFile = await drive.files.create(FilesRequest.create(
      fileMetadata,
      fileContent: fileContent,
    ));

    log("Created File: $createdFile");

    setState(() {
      responsesToDisplay.add("Created Files Name: " + createdFile.fileName);
      fileId = createdFile.id;
    });
  }

  void _listFiles() async {
    DriveFileList fileList = await drive.files.list(FilesRequest.list(
      fields: "*",
      pageSize: 5,
    ));

    log("File List: $fileList");

    List<String> fileNames = [];
    for (int i = 0; i < fileList.files.length; i++) {
      fileNames.add(fileList.files[i].fileName);
    }

    setState(() {
      responsesToDisplay.add("Files on Drive: " + fileNames.toString());
    });
  }

  void _updateFileName() async {
    DriveFile updatedMetadata = DriveFile(fileName: "updatedFile.jpg");

    DriveFile updatedFile =
        await drive.files.update(FilesRequest.update(fileId, updatedMetadata));

    log("Updated File: $updatedFile");

    setState(() {
      responsesToDisplay.add("Updated File Name: " + updatedFile.fileName);
    });
  }

  void _downloadFile() async {
    final directory = await getExternalStorageDirectory();

    bool result = await drive.files.getContentAndDownloadTo(
      FilesRequest.getRequest(
        fileId,
        fields: "*",
      ),
      directory.path + "/downloadedImage.jpg",
    );

    log(result.toString());

    setState(() {
      responsesToDisplay.add("Download Compelete.");
    });
  }

  void _createComment() async {
    DriveComment comment = DriveComment(
      description: "This is a comment.",
    );

    DriveComment createdComment =
        await drive.comments.create(CommentsRequest.create(fileId, comment));

    log("Created Comment: $createdComment");

    setState(() {
      commentId = createdComment.id;
      responsesToDisplay.add("Comment Added: " + createdComment.description);
    });
  }

  void _commentList() async {
    DriveCommentList commentList =
        await drive.comments.list(CommentsRequest.list(fileId));

    log("Comment List: $commentList");

    List<String> commentDescriptions = [];
    for (int i = 0; i < commentList.comments.length; i++) {
      commentDescriptions.add(commentList.comments[i].description);
    }

    setState(() {
      responsesToDisplay
          .add("Comments on File: " + commentDescriptions.toString());
    });
  }

  void _replyComment() async {
    DriveReply reply = DriveReply(
      description: "This is a reply.",
    );

    DriveReply createdReply = await drive.replies
        .create(RepliesRequest.create(fileId, commentId, reply));

    log("Created Reply: $createdReply");

    setState(() {
      responsesToDisplay.add("Reply Added: " + createdReply.description);
    });
  }

  void _replyList() async {
    DriveReplyList replyList =
        await drive.replies.list(RepliesRequest.list(fileId, commentId));

    log("Reply List: $replyList");

    List<String> replyDescriptions = [];
    for (int i = 0; i < replyList.replies.length; i++) {
      replyDescriptions.add(replyList.replies[i].description);
    }

    setState(() {
      responsesToDisplay
          .add("Comments on File: " + replyDescriptions.toString());
    });
  }

  void _batch() async {
    List<Batchable> batchRequests = [
      FilesRequest.create(
        DriveFile(
            fileName: "folderCreatedByBatch",
            mimeType: "application/vnd.huawei-apps.folder"),
      ),
    ];

    if (fileId != null) {
      batchRequests.add(
        CommentsRequest.create(
            fileId,
            DriveComment(
              description: "This is a comment created by batch operation.",
            )),
      );
    }

    if (fileId != null && commentId != null) {
      batchRequests.add(
        RepliesRequest.create(
            fileId,
            commentId,
            DriveReply(
              description: "This is a reply created by batch operation.",
            )),
      );
    }

    await drive.batch.execute(BatchRequest(batchRequests));
  }

  void _deleteFile() async {
    bool result = await drive.files.delete(FilesRequest.delete(fileId));

    log(result.toString());

    setState(() {
      responsesToDisplay.add("Deleted File.");
      commentId = null;
      fileId = null;
    });
  }

  void _emptyRecycle() async {
    bool result = await drive.files.emptyRecycle(FilesRequest.emptyRecycle());

    log(result.toString());

    setState(() {
      responsesToDisplay.add("Emptied Recycle Folder.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Drive Kit Demo'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                onPressed: requestPermissions,
                text: "Check Permissions",
              ),
              CustomButton(
                onPressed: _getAbout,
                text: "About",
              ),
              CustomButton(
                onPressed: _createFile,
                text: "Create File on Drive",
              ),
              CustomButton(
                onPressed: _listFiles,
                text: "List Files",
              ),
              CustomButton(
                onPressed: fileId == null ? fileIdSnackbar : _updateFileName,
                text: "Update File Name",
              ),
              CustomButton(
                onPressed: fileId == null ? fileIdSnackbar : _downloadFile,
                text: "Download File to Local Storage",
              ),
              CustomButton(
                onPressed: fileId == null ? fileIdSnackbar : _createComment,
                text: "Create Comment",
              ),
              CustomButton(
                onPressed: fileId == null ? fileIdSnackbar : _commentList,
                text: "List Comments",
              ),
              CustomButton(
                onPressed: (fileId == null || commentId == null)
                    ? fileCommentIdSnackbar
                    : _replyComment,
                text: "Reply the Comment",
              ),
              CustomButton(
                onPressed: (fileId == null || commentId == null)
                    ? fileCommentIdSnackbar
                    : _replyList,
                text: "List Replies",
              ),
              CustomButton(
                onPressed: _batch,
                text: "Batch Operations",
              ),
              CustomButton(
                onPressed: fileId == null ? fileIdSnackbar : _deleteFile,
                text: "Delete the File",
              ),
              CustomButton(
                onPressed: _emptyRecycle,
                text: "Empty Recycle Folder",
              ),
              CustomConsole(
                responses: responsesToDisplay,
              )
            ],
          ),
        ),
      ),
    );
  }
}
