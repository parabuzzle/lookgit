// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}})
jQuery(document).ready(function($) {$('a[rel*=facebox]').facebox() })

var obj = null;

function checkHover() {
   if (obj) {
      obj.find('.blist').fadeOut('fast');
   } //if
} //checkHover

jQuery(document).ready(function() {
   jQuery('.branches').hover(function() {
      if (obj) {
         obj.find('.blist').fadeOut('fast');
         obj = null;
      } //if

      jQuery(this).find('.blist').fadeIn('fast');
   }, function() {
      obj = jQuery(this);
      setTimeout(
         "checkHover()",
         400);
   });
});
