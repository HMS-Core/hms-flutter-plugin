/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_gameservice;

/// Provides APIs for archive management, for example, APIs for submitting and deleting archives.
abstract class ArchivesClient {
  /// Submits an archive.
  static Future<ArchiveSummary> addArchive(
    ArchiveDetails details,
    ArchiveSummaryUpdate update,
    bool isSupportCache,
  ) async {
    final dynamic result = await _channel.invokeMethod(
      'ArchivesClient.addArchive',
      <String, dynamic>{
        'detailsContent': details.content,
        'update': update.toMap(),
        'isSupportCache': isSupportCache,
      },
    );
    return ArchiveSummary.fromMap(Map<dynamic, dynamic>.from(result));
  }

  /// Deletes an archive.
  static Future<String> removeArchive(ArchiveSummary summary) async {
    return await _channel.invokeMethod(
      'ArchivesClient.removeArchive',
      <String, dynamic>{
        'summary': summary.toMap(),
      },
    );
  }

  /// Obtains the maximum size of an archive cover file allowed by Huawei game server.
  static Future<int> getLimitThumbnailSize() async {
    return await _channel.invokeMethod(
      'ArchivesClient.getLimitThumbnailSize',
    );
  }

  /// Obtains the maximum size of an archive file allowed by Huawei game server.
  static Future<int> getLimitDetailsSize() async {
    return await _channel.invokeMethod(
      'ArchivesClient.getLimitDetailsSize',
    );
  }

  /// Launches the Intent for the saved game list page.
  static Future<void> showArchiveListIntent(
    String title,
    bool allowAddButton,
    bool allowDeleteButton,
    int maxArchive,
  ) async {
    return await _channel.invokeMethod(
      'ArchivesClient.showArchiveListIntent',
      <String, dynamic>{
        'title': title,
        'allowAddButton': allowAddButton,
        'allowDeleteButton': allowDeleteButton,
        'maxArchive': maxArchive,
      },
    );
  }

  /// Obtains all archive data.
  ///
  /// The data can be obtained from the local cache by specifying the [isRealTime] parameter as `false`.
  static Future<List<ArchiveSummary>> getArchiveSummaryList(
    bool isRealTime,
  ) async {
    final List<dynamic> result = await _channel.invokeMethod(
      'ArchivesClient.getArchiveSummaryList',
      <String, dynamic>{
        'isRealTime': isRealTime,
      },
    );
    return List<ArchiveSummary>.from(
      result.map(
        (dynamic map) => ArchiveSummary.fromMap(
          Map<dynamic, dynamic>.from(map),
        ),
      ),
    );
  }

  /// Reads archive data.
  ///
  /// Specify an [ArchiveSummary] object or an [archiveId] to read the archive data.
  /// A conflict resolution policy can be specified by setting the [diffStrategy].
  /// The [diffStrategy] setting values can be found on the [ArchiveConstants] class.
  static Future<OperationResult> loadArchiveDetails({
    ArchiveSummary? summary,
    String? archiveId,
    int? diffStrategy,
  }) async {
    final dynamic result = await _channel.invokeMethod(
      'ArchivesClient.loadArchiveDetails',
      removeNulls(
        <String, dynamic>{
          'summary': summary?.toMap(),
          'archiveId': archiveId,
          'diffStrategy': diffStrategy,
        },
      ),
    );
    return OperationResult.fromMap(Map<dynamic, dynamic>.from(result));
  }

  /// Resolves a data conflict by passing archive data.
  static Future<OperationResult> updateArchiveByData(
    String archiveId,
    ArchiveSummaryUpdate update,
    ArchiveDetails archiveDetails,
  ) async {
    final dynamic result = await _channel.invokeMethod(
      'ArchivesClient.updateArchiveByData',
      <String, dynamic>{
        'archiveId': archiveId,
        'update': update.toMap(),
        'archiveDetails': archiveDetails.toMap(),
      },
    );
    return OperationResult.fromMap(Map<dynamic, dynamic>.from(result));
  }

  /// Resolves a data conflict by passing an archive object.
  static Future<OperationResult> updateArchive(Archive archive) async {
    final dynamic result = await _channel.invokeMethod(
      'ArchivesClient.updateArchive',
      <String, dynamic>{
        'archive': archive.toMap(),
      },
    );
    return OperationResult.fromMap(Map<dynamic, dynamic>.from(result));
  }

  /// Obtains the cover data of a specified archive.
  static Future<Int8List> getThumbnail(String archiveId) async {
    final dynamic result = await _channel.invokeMethod(
      'ArchivesClient.getThumbnail',
      <String, dynamic>{
        'archiveId': archiveId,
      },
    );
    return Int8List.fromList(result);
  }
}
