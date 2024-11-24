class LoadingException implements Exception {
  String message;

  LoadingException({this.message = "Error occured while loading file"});
}



class CacheException implements Exception{
	String message;

	CacheException({this.message = "Error occured while caching"});
}
