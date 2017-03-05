
(function() {
  var i = window.setInterval(() => {
    if(settings) {
      window.clearInterval(i)
      if(settings.newtaburl) {
        window.location.href = settings.newtaburl
      }
    }
  }, 0)
  
}())
