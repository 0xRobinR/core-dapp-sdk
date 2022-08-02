
ethereum = {
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
}