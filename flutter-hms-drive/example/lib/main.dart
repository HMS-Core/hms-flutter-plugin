/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:huawei_drive/huawei_drive.dart';
import 'package:huawei_drive_example/custom_widgets/custom_loading.dart';
import 'package:huawei_drive_example/custom_widgets/custom_button.dart';
import 'package:huawei_drive_example/custom_widgets/custom_console.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );
  runApp(
    const MaterialApp(
      home: HomeScreenView(),
    ),
  );
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final List<String> _responsesToDisplay = <String>[];
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AccountAuthParamsHelper _helper;
  late AccountAuthService _authService;
  AuthAccount? _account;
  late Drive _drive;
  String? _fileId;
  String? _commentId;
  bool get userLoggedIn => _account != null;
  @override
  void initState() {
    super.initState();
    _helper = AccountAuthParamsHelper()
      ..setAccessToken()
      ..setId()
      ..setProfile()
      ..setAssistToken()
      ..setAuthorizationCode()
      ..setCarrierId()
      ..setDialogAuth()
      ..setEmail()
      ..setForceLogout()
      ..setIdToken()
      ..setMobileNumber()
      ..setUid()
      ..setScopeList(
        <Scope>[
          Scope.profile,
          Scope.openId,
          Scope.accountBirthday,
          Scope.accountCountry,
          Scope.accountMobileNumber,
          Scope.ageRange,
          Scope.email,
          Scope.game
        ],
        extraScopeURIs: <String>[
          scopeBaseProfile,
          scopeDrive,
          scopeDriveFile,
          scopeDriveReadOnly,
          scopeDriveMetaData,
          scopeDriveMetaDataReadOnly,
          scopeDriveAppData,
        ],
      );
    _authService = AccountAuthManager.getService(_helper.createParams());
    signIn();
    permissionCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Drive Kit Demo'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: _appBarActions(context: context),
      ),
      body: _body(context: context),
    );
  }

  List<Widget> _appBarActions({
    required BuildContext context,
  }) {
    return userLoggedIn
        ? <Widget>[
            IconButton(
              onPressed: () async {
                await signOut();
              },
              icon: const Icon(Icons.logout_outlined),
            )
          ]
        : <Widget>[];
  }

  Widget _body({
    required BuildContext context,
  }) {
    return Stack(
      children: <Widget>[
        userLoggedIn
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomButton(
                        onPressed: permissionCheck,
                        text: 'Check Permissions',
                      ),
                      CustomButton(
                        onPressed: getAbout,
                        text: 'About',
                      ),
                      CustomButton(
                        onPressed: createFile,
                        text: 'Create File on Drive',
                      ),
                      CustomButton(
                        onPressed: listFiles,
                        text: 'List Files',
                      ),
                      CustomButton(
                        onPressed: updateFileName,
                        text: 'Update File Name',
                      ),
                      CustomButton(
                        onPressed: downloadFile,
                        text: 'Download File to Local Storage',
                      ),
                      CustomButton(
                        onPressed: createComment,
                        text: 'Create Comment',
                      ),
                      CustomButton(
                        onPressed: commentList,
                        text: 'List Comments',
                      ),
                      CustomButton(
                        onPressed: replyComment,
                        text: 'Reply the Comment',
                      ),
                      CustomButton(
                        onPressed: replyList,
                        text: 'List Replies',
                      ),
                      CustomButton(
                        onPressed: batch,
                        text: 'Batch Operations',
                      ),
                      CustomButton(
                        onPressed: deleteFile,
                        text: 'Delete the File',
                      ),
                      CustomButton(
                        onPressed: emptyRecycle,
                        text: 'Empty Recycle Folder',
                      ),
                      CustomConsole(
                        responses: _responsesToDisplay,
                      )
                    ],
                  ),
                ),
              )
            : _signInButton(onPressed: signIn),
        _isLoading ? const CustomLoading() : const SizedBox()
      ],
    );
  }

  Widget _signInButton({required AsyncCallback onPressed}) {
    return Center(
      child: CustomButton(
        onPressed: onPressed,
        text: 'Sign In',
      ),
    );
  }

  void showSnackBar(String message) {
    BuildContext? context = _scaffoldKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  Future<void> permissionCheck() async {
    try {
      setLoading(true);

      bool status = await HmsDrivePermissions.requestReadAndWritePermission();
      String response = 'Request Permission State: $status';

      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> signIn() async {
    try {
      setLoading(true);

      _account = await _authService.signIn();
      String? unionId = _account?.unionId;
      RefreshTokenCallback refreshTokenCallback = _refreshToken;
      DriveCredentials deviceCredentials = DriveCredentials(
        unionId: unionId,
        accessToken: _account?.accessToken,
        callback: refreshTokenCallback,
      );
      _drive = await Drive.init(deviceCredentials);
      log('User: ${_account?.displayName}');
      _drive.batch.onBatchResult.listen(_onBatchEvent, onError: _onBatchError);

      setLoading(false);
    } catch (_) {
      _displaySnackbar(_SnackbarMessages.signInError);
    }
  }

  Future<String?> _refreshToken() async {
    _account = await _authService.silentSignIn();
    return _account?.accessToken;
  }

  Future<void> getAbout() async {
    try {
      setLoading(true);
      DriveAbout about = await _drive.about(AboutRequest());
      String response = 'User Display Name: ${about.user?.displayName}';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> createFile() async {
    try {
      setLoading(true);
      ByteData byteData = await rootBundle.load('assets/Snake_River_(5mb).jpg');
      Int8List byteArray = byteData.buffer
          .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes);

      DriveFile fileMetadata = DriveFile(
        fileName: 'Snake_River.jpg',
        mimeType: 'image/jpg',
      );

      DriveFileContent fileContent = DriveFileContent(
        type: 'image/jpg',
        byteArray: byteArray,
      );

      DriveFile createdFile = await _drive.files.create(
        FilesRequest.create(
          fileMetadata,
          fileContent: fileContent,
        ),
      );

      _fileId = createdFile.id;
      String response = 'Created Files Name: ${createdFile.fileName}';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> listFiles() async {
    try {
      setLoading(true);
      DriveFileList fileList = await _drive.files.list(
        FilesRequest.list(
          fields: '*',
          pageSize: 5,
        ),
      );

      List<String?> fileNames = <String?>[];
      for (int i = 0; i < fileList.files.length; i++) {
        log('${fileList.files[i].id} -- ${fileList.files[i].fileName}');
        fileNames.add(fileList.files[i].fileName);
      }
      String response = 'Files on Drive: $fileNames';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> updateFileName() async {
    try {
      if (_fileId == null) {
        _displaySnackbar(_SnackbarMessages.fileIdIsNull);
        return;
      }
      setLoading(true);
      DriveFile updatedMetadata = DriveFile(fileName: 'updatedFile.jpg');

      DriveFile updatedFile = await _drive.files
          .update(FilesRequest.update(_fileId, updatedMetadata));

      String response = 'Updated File Name: ${updatedFile.fileName}';

      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> downloadFile() async {
    try {
      final Directory? directory = await getExternalStorageDirectory();
      String? path = directory?.path;
      if (path == null) {
        _displaySnackbar(_SnackbarMessages.downloadPathIsNull);
        return;
      }

      if (_fileId == null) {
        _displaySnackbar(_SnackbarMessages.fileIdIsNull);
        return;
      }
      setLoading(true);
      await _drive.files.getContentAndDownloadTo(
        FilesRequest.getRequest(
          _fileId,
          fields: '*',
        ),
        '$path/downloadedImage.jpg',
      );

      String? response = 'Download Compelete.';

      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> createComment() async {
    try {
      if (_fileId == null) {
        _displaySnackbar(_SnackbarMessages.fileIdIsNull);
        return;
      }
      setLoading(true);
      DriveComment comment = DriveComment(
        description: 'This is a comment.',
      );
      DriveComment createdComment = await _drive.comments
          .create(CommentsRequest.create(_fileId, comment));
      _commentId = createdComment.id;
      String? response = 'Comment Added: ${createdComment.description}';

      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> commentList() async {
    try {
      if (_fileId == null) {
        _displaySnackbar(_SnackbarMessages.fileIdIsNull);
        return;
      }
      setLoading(true);
      DriveCommentList commentList =
          await _drive.comments.list(CommentsRequest.list(_fileId));

      List<String?> commentDescriptions = <String?>[];
      for (int i = 0; i < commentList.comments.length; i++) {
        commentDescriptions.add(commentList.comments[i].description);
      }
      String? response = 'Comments on File: $commentDescriptions';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> replyComment() async {
    try {
      if (_fileId == null || _commentId == null) {
        _displaySnackbar(_SnackbarMessages.fileCommentIdIsNull);
        return;
      }
      setLoading(true);
      DriveReply reply = DriveReply(
        description: 'This is a reply.',
      );
      DriveReply createdReply = await _drive.replies
          .create(RepliesRequest.create(_fileId, _commentId, reply));
      String? response = 'Reply Added: ${createdReply.description}';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> replyList() async {
    try {
      if (_fileId == null || _commentId == null) {
        _displaySnackbar(_SnackbarMessages.fileCommentIdIsNull);
        return;
      }
      setLoading(true);
      DriveReplyList replyList =
          await _drive.replies.list(RepliesRequest.list(_fileId, _commentId));
      List<String?> replyDescriptions = <String?>[];
      for (int i = 0; i < replyList.replies.length; i++) {
        replyDescriptions.add(replyList.replies[i].description);
      }
      String? response = 'Comments on File: $replyDescriptions';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> batch() async {
    try {
      setLoading(true);
      List<Batchable> batchRequests = <Batchable>[
        FilesRequest.create(
          DriveFile(
            fileName: 'sampleFolder',
            mimeType: 'application/vnd.huawei-apps.folder',
          ),
        ),
      ];

      if (_fileId != null) {
        log('here we go');
        batchRequests.add(
          CommentsRequest.create(
            _fileId,
            DriveComment(
              description: 'This is a comment created by batch operation.',
            ),
          ),
        );
      }

      if (_fileId != null && _commentId != null) {
        log('here we go');
        batchRequests.add(
          RepliesRequest.create(
            _fileId,
            _commentId,
            DriveReply(
              description: 'This is a reply created by batch operation.',
            ),
          ),
        );
      }

      await _drive.batch.execute(BatchRequest(batchRequests));
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> deleteFile() async {
    try {
      if (_fileId == null) {
        _displaySnackbar(_SnackbarMessages.fileIdIsNull);
        return;
      }
      setLoading(true);
      bool result = await _drive.files.delete(FilesRequest.delete(_fileId));
      if (!result) {
        String? response = 'Could not delete file.';
        _responsesToDisplay.add(response);
        setLoading(false);
        return;
      }
      _commentId = null;
      _fileId = null;
      String? response = 'Deleted File.';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> emptyRecycle() async {
    try {
      setLoading(true);
      bool result =
          await _drive.files.emptyRecycle(FilesRequest.emptyRecycle());
      String? response;
      if (!result) {
        response = 'Could not make recycle folder empty';
      }
      response = 'Emptied Recycle Folder.';
      _responsesToDisplay.add(response);
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  Future<void> signOut() async {
    try {
      setLoading(true);
      bool didSignOut = await _authService.signOut();
      if (!didSignOut) {
        String message = 'Could not sign out';
        _displaySnackbar(message);
        setLoading(false);
        return;
      }
      bool didCancelAuth = await _authService.cancelAuthorization();
      if (!didCancelAuth) {
        String message = 'Could not cancel authorization';
        _displaySnackbar(message);
        setLoading(false);
        return;
      }
      _account = null;
      setLoading(false);
    } catch (e) {
      _displaySnackbar(_SnackbarMessages.defaultError);
    }
  }

  void setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void _displaySnackbar(String message) {
    setLoading(false);
    showSnackBar(message);
  }

  void _onBatchError(Object error) {
    if (error is PlatformException) {
      log("BatchError: ${jsonDecode(error.message ?? "")}");
    }
  }

  void _onBatchEvent(dynamic event) {
    String message = 'Batch Operation - Success';
    setState(() {
      _responsesToDisplay.add(message);
    });
  }
}

extension _SnackbarMessages on HomeScreenView {
  static const String fileIdIsNull = 'FileId is empty. Please create a file.';
  static const String fileCommentIdIsNull =
      'Either file or comment id is empty. Please create a comment on created file.';
  static const String downloadPathIsNull = 'Downloads directory path is null';
  static const String defaultError = 'Operation could not succeed';
  static const String signInError = 'Could not sign in';
}
