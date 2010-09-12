// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function()
{
  $('#message_panel').jScrollPane(
    {
      showArrows: true,
      horizontalGutter: 10
    }
  );
  // quick flip setup
  $('.card_wrapper').quickFlip({ vertical: true, panelWidth: 77, panelHeight: 100});
});
