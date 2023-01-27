buildError({code, message}) {
  return {
    "success": false,
    "error": {
      "code": code,
      "message": message,
      "data": {"code": code, "message": message}
    }
  };
}

buildSuccess({data}) {
  return {"success": true, "error": false, "data": data};
}
