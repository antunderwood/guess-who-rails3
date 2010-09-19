module MessagesHelper
  def message_js_call(content)
    "api.getContentPane().prepend('<div class=\"cssbox-blue\"><div class=\"cssbox_head-blue\"> <h2>Dad&nbsp; <img src=\"../images/question_mark_button_small.png\"/></h2></div> <div class=\"cssbox_body-blue\">" + escape_javascript(content) +"</div></div>');api.reinitialise();"
  end
end
