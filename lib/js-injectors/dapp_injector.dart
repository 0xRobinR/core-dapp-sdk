const script = '''
function ready(callback){
    // in case the document is already rendered
    if (document.readyState!='loading') callback();
    // modern browsers
    else if (document.addEventListener) document.addEventListener('DOMContentLoaded', callback);
    // IE <= 8
    else document.attachEvent('onreadystatechange', function(){
        if (document.readyState=='complete') callback();
    });
}

ready(function(){
  // console.log(window)
  window.ethereum = {
      request: (payload) => {
          return new Promise((resolve, reject) => {
              if ( window.flutter_inappwebview ) {
                  window.flutter_inappwebview.callHandler(payload.method, payload.params).then(function(result) {
                      if ( result.success ) {
                          resolve(result.data);
                      } else {
                          reject(result.error);
                      }
                  }).catch((err) => reject(err));
              } else {
                  reject("!web3 not injected")
              }
          })
      }
  };   
});
''';
