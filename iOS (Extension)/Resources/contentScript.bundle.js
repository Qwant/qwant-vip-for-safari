(()=>{const e=[{engine:"google.",query:"q",client:"client",source:"safari"},{engine:"search.yahoo.",query:"p",client:"fr",source:"iphone"},{engine:"bing.",query:"q",client:"form",source:"APIPH1"},{engine:"duckduckgo.",query:"q",client:"t",source:"iphone"},{engine:"ecosia.",query:"q",client:"tts",source:"st_asaf_iphone"}];function n(e,n){const c=new RegExp(`[?&]${e.replace(/[\[\]]/g,"\\$&")}(=([^&#]*)|&|#|$)`).exec(n);return c?c[2]?c[2].replace(/\+/g," "):"":null}(async()=>{try{const c=window.location,t=function(c){const t=e.find((e=>c.host.includes(e.engine)));return t&&n(t.client,c.href)===t.source?t:null}(c);if(null==t)return;const o=n(t.query,c.href);c.replace(`https://www.qwant.com/?client=ext-safari-ios-sb&t=web&q=${o}`)}catch(e){console.trace(e)}})()})();
