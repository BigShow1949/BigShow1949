
//通过拦截URL来实现调用原生功能(js 调用 oc实现)
function setupWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
};


function onLoaded(){
    
//    alert('onLoaded被调用');
    var allImage = document.querySelectorAll("img");
    allImage = Array.prototype.slice.call(allImage, 0);
    var imageInfos = new Array();
    allImage.forEach(function(image) {
                     var imageSrc = image.getAttribute("img-src");
                     var imageIndex = image.getAttribute("img-index");
                     imageInfos.push(new Array(imageIndex,imageSrc));
                     });
    //调用OC的onLoaded方法
    WebViewJavascriptBridge.callHandler('onLoaded',imageInfos, function(response){
                                        
                                        })
};

function onImageClicked(imageIndex) {
    
    var image = getImageAtIndex(imageIndex);
    
    x = image.getBoundingClientRect().left;
    y = image.getBoundingClientRect().top;
    x = x + document.documentElement.scrollLeft;
    y = y + document.documentElement.scrollTop;
    width = image.width;
    height = image.height;
    var array = new Array(imageIndex,x,y,width,height);
//    var dic = {'index':index,'x':x,'y':y,'width':width,'height':height}
//    alert('x=' + x + ',y=' + y + ',width=' + width  + ',height=' + height);
//    alert(array);
    WebViewJavascriptBridge.callHandler('browImage',array, function(response){
                                    
                                        })
};

//注册方法，OC调用JS
setupWebViewJavascriptBridge(function(bridge) {

        bridge.registerHandler('imageDownLoadCompleted', function(data, responseCallback) {
                               
//                               alert('index = ' + data[0] + 'filepath = ' + data[1]);
                               image = getImageAtIndex(data[0])
                               image.src = data[1];
                               });
                             
});


//获取图片对象
function getImageAtIndex(imageIndex){
    
    var allImage = document.querySelectorAll("img");
    allImage = Array.prototype.slice.call(allImage, 0);
    image = allImage[imageIndex]
    return image;
};


                             
                             
                             
