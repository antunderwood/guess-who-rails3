// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
soundManager.url = '/sounds/'; // override default SWF url
soundManager.debugMode = false;
soundManager.onload = function() {soundManager.createSound('message','/sounds/message.mp3');};
$(function()
{
  var scrollPaneSettings = {
    showArrows: true,
  };
  
  var scrollPane = $('#message_panel')
  scrollPane.jScrollPane(scrollPaneSettings);
  api = scrollPane.data('jsp');

  // quick flip setup
  $('.card_wrapper').quickFlip({ vertical: true, panelWidth: 77, panelHeight: 100});
  //add word button click
  $('.word_button').click(function(){$('#question').val($('#question').val() + $(this).html() + " ");});
  
  // peridic call
  periodic = $.periodic({period: 2000, decay: 1.0}, function() {
    $.ajax({url: '/messages'});
  });
 $('#stop').click(function(){periodic.cancel();});
 $('#start').click(function(){periodic.reset();});
  
});

