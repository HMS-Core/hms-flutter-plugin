/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_site;

class QueryAutocompleteResponse {
  List<Site?>? sites;
  List<AutoCompletePrediction?>? predictions;

  QueryAutocompleteResponse({
    this.sites,
    this.predictions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sites': sites?.map((Site? x) => x?.toMap()).toList(),
      'predictions': predictions?.map((AutoCompletePrediction? x) {
        return x?.toMap();
      }).toList(),
    };
  }

  factory QueryAutocompleteResponse.fromMap(Map<dynamic, dynamic> map) {
    return QueryAutocompleteResponse(
      sites: map['sites'] != null
          ? List<Site>.from(map['sites']?.map((dynamic x) => Site.fromMap(x)))
          : null,
      predictions: map['predictions'] != null
          ? List<AutoCompletePrediction>.from(
              map['predictions']?.map(
                (dynamic x) => AutoCompletePrediction.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory QueryAutocompleteResponse.fromJson(String source) {
    return QueryAutocompleteResponse.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$QueryAutocompleteResponse('
        'sites: $sites, '
        'predictions: $predictions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QueryAutocompleteResponse &&
        listEquals(other.sites, sites) &&
        listEquals(other.predictions, predictions);
  }

  @override
  int get hashCode {
    return sites.hashCode ^ predictions.hashCode;
  }
}
