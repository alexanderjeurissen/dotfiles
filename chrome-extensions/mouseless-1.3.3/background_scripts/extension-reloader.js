'use strict';

class ExtensionReloader {

  start() {
    var lastModified = (new Date());
    
    window.setInterval(v => {
      chrome.runtime.getPackageDirectoryEntry(dir => {
        dir.getFile('.extension-reloader', {}, fe => {
          fe.file(file => {
            if (file.lastModified > lastModified) {
              chrome.runtime.reload();
            }
          }, null);
        }, err => {
          console.error(err);
        });
      });
    }, 500);
  }
}

var er = new ExtensionReloader();

//er.start();
//chrome.tabs.query({}, tabs => {
//  tabs.forEach(tab => {
//    if(!tab.url.startsWith('chrome')) {
//      chrome.tabs.reload(tab.id);
//    }
//  });
//});
