var exec = require('cordova/exec');
/**
 * Constructor
 */
function MyPlugin() {}

MyPlugin.prototype.getCarrierInfo = function() {
  exec(function(result){
      // result handler
      return(result);
    },
    function(error){
      // error handler
      return("Error" + error);
    }, 
    "MyPlugin", 
    "getCarrierInfo",
    []
  );
}

var myPlugin = new MyPlugin();
module.exports = myPlugin
