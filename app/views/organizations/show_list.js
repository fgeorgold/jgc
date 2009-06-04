/**
 * @author Nipun
 */
function typeChanged(areaToUpdate, typesToSend) {
  // Manually create a request string with parameters
  var queryStr = "/node/update_list";
  var started = false;
  if (typesToSend) {
    for (var i = 0; i < typesToSend.length; i++) {
      // the first type must have ? before it to start the parameters list.
      // after that, it should be prepended with & to specify an additional
      // parameter.
      queryStr += (started ? "&" : "?") + "types[]=" + typesToSend[i];
      started = true;
    }
  }
  
  // before we send the request, show the hourglass.
  
  
  // manually send an Ajax request to update the area passed in to the 
  // function.  Upon completion, hide the hourglass.  You can also specify
  // functions to run for onError, onSuccess, and many others.
  new Ajax.Updater(areaToUpdate, queryStr);
}