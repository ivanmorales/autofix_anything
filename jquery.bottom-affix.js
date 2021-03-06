// Generated by CoffeeScript 1.7.1

/*
 ===========================================================
 * jquery.bottom-affix.js v1
 * ===========================================================
 * Copyright 2013 Pete Rojwongsuriya.
 * http://www.thepetedesign.com
 *
 * Modified 2014 Ivan Morales
 * http://www.imorales.com
 *
 ==========================================================
 */
(function($, window) {
  var defaults;
  defaults = {
    customOffset: false,
    manual: false,
    onlyInContainer: true,
    container: null,
    parentOffset: 0
  };
  $.fn.autofix_anything = function(options) {
    var auto, container, el, fixAll, offset, settings;
    settings = $.extend({}, defaults, options);
    el = $(this);
    el.data['curpos'] = el.position();
    offset = settings.customOffset;
    auto = 'auto';
    container = settings.container != null ? el.closest(settings.container) : el.parent();
    el.addClass('autofix_sb');
    fixAll = function(el, settings, curpos) {
      var containerHeight, containerTop, elHeight, pos, scrollTop, top, viewHeight;
      pos = el.offset();
      if (el.outerHeight() >= container.outerHeight()) {
        return;
      }
      top = isNaN(settings.parentOffset) ? $(settings.parentOffset).outerHeight() : settings.parentOffset;
      if (settings.customOffset === false) {
        offset = container.offset().top - top;
      }
      scrollTop = $(document).scrollTop();
      containerHeight = container.height();
      containerTop = container.offset().top;
      elHeight = el.outerHeight();
      viewHeight = $(window).height();
      if ((scrollTop + viewHeight) < (containerTop + elHeight)) {
        el.removeClass('bottom fixed').addClass('fixed').trigger('nc-fixed').css({
          top: 0
        });
      } else {
        if (scrollTop > offset) {
          if ((scrollTop + viewHeight) < (containerTop + containerHeight)) {
            el.addClass('bottom fixed').removeAttr('style').trigger('nc-fixed-bottom').css({
              top: auto,
              left: curpos.left
            });
          } else {
            el.removeClass('bottom').removeAttr('style').trigger('nc-fixed').css({
              top: "" + (containerHeight - elHeight) + "px"
            });
          }
        }
      }
    };
    if (settings.manual === false) {
      $(window).on('scroll.autofix_anything, resize.autofix_anything', function() {
        fixAll(el, settings, el.data['curpos']);
      });
    }
  };

  /* 
  AUTOFIX_ANYTHING DATA-API
  =========================
   */
  $(window).on('load', function() {
    $('[data-spy="autofix_anything"]').each(function() {
      var $spy, data, key, options;
      $spy = $(this);
      data = $spy.data();
      options = {};
      for (key in defaults) {
        options[key] = data[key.toLowerCase()];
      }
      $spy.autofix_anything(options);
    });
  });
})(jQuery, window);
