const script = '''
function ready(callback){
    if (document.readyState!='loading') callback();
    else if (document.addEventListener) document.addEventListener('DOMContentLoaded', callback);
    else document.attachEvent('onreadystatechange', function(){
        if (document.readyState=='complete') callback();
    });
}

ready(function(){
  // alert("loaded")
  window.ethereum = {
      request: (payload) => {
          return new Promise((resolve, reject) => {
              if ( window.flutter_inappwebview ) {
                  window.flutter_inappwebview.callHandler(payload.method, payload.params).then(function(result) {
                      console.log(payload.method)
                      console.log(result)
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
  window.ethereum.request({method: "eth_chainId"}).then((res) => console.log(res))
});
''';
