var checkStatus = function (jid) {
  $.get('/status/' + jid, function(jobStatus){
    if (jobStatus == "true") {
      $("#response").html("Your tweet has posted.");
    } else {
      setTimeout(checkStatus, 1000, jid);
    }
  });
};

$(document).ready(function() {

  $('form#new_tweet').submit(function(e){
    e.preventDefault();
    $("#response").html("");
    $(this).attr('disabled', 'disabled');
    var data = $('textarea').serialize();
    var route = $(this).attr('action');
    $.post("/twitter", data, function(response){
      $("#response").html("Your tweet is pending.");
      $("form")[0].reset();
      var isFinished = "false";
      var jid = response;
      checkStatus(jid);
    });
  });

});
