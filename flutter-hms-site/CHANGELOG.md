## 5.1.0+301

* Updated HMSLogger.
* Removed the deprecated **setPoliticalView** method.

## 5.1.0+300

* The error which raised when deserializing NaN values is fixed.
* SearchService can be initialized by calling **create** named constructor.
* SearchService is now requires apiKey parameter to be set.
* SearchIntent is now requires apiKey parameter to be set.
* Added the **autocomplete API**.
* Added the **tertiaryAdminArea** attribute to **AddressDetail**.
* Added the **utcOffset** attribute to the **Site** object returned by the place detail search API, and added the **priceLevel**, **businessStatus**, and **openingHours** attributes to the **Poi** object.
* Added the **prediction** attribute to the **Site** object returned by the place search suggestion and autocomplete APIs.
* Added the optional parameter **children** to the keyword search, place detail search, place search suggestion, widget, and autocomplete APIs. The parameter indicates whether to return the child node.
* Added the **childrenNodes** attribute to the **Poi** object.
* Added the **strictBounds** attribute for **NearbySearchRequest**, indicating whether to strictly restrict place search in the bounds specified by **location** and **radius**.
* Added the **strictBounds** attribute for **QuerySuggestionRequest** and **SearchFilter**, indicating whether to strictly restrict place search in the bounds specified by **Bounds**.
* Deprecated the **setPoliticalView** method in the **TextSearchRequest**, **NearbySearchRequest**, **DetailSearchRequest**, **QueryAutocompleteRequest**, **QuerySuggestionRequest**, and **SearchFilter** classes.

## 5.0.1+300

* Added the **siteSearchActivity** method.
* Added the **SearchIntent** class to start site search activity.
* Added the **SearchFilter** class, which is used in a SearchIntent object as **filter**.
* Added the **streetNumber** attribute in the **AddressDetail** class, which is used for setting or obtaining the street number of a place.
* Added the **HwLocationType** class, which contains constants of Huawei POI types.
* Added the **enableLogger** and **disableLogger** methods.

## 4.0.4

* Initial release.
