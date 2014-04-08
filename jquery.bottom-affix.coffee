###
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
###

do($ = jQuery, window)->
    defaults = 
        customOffset: false
        manual: false
        onlyInContainer: true
        container: null
        parentOffset: 0 

    $.fn.autofix_anything = (options)->
        settings = $.extend {}, defaults, options
        el = $(@)
        el.data['curpos'] = el.position()
        offset = settings.customOffset
        auto = 'auto'
        container = if settings.container? then el.closest(settings.container) else el.parent()

        el.addClass 'autofix_sb'

        fixAll = (el, settings, curpos)->
            pos = el.offset()
            # If fixed element is taller than the container, don't do anything
            if el.outerHeight() >= container.outerHeight()
                return

            top = if isNaN(settings.parentOffset) then $(settings.parentOffset).outerHeight() else settings.parentOffset

            offset = container.offset().top - top if settings.customOffset is false

            scrollTop = $(document).scrollTop()
            containerHeight = container.height()
            containerTop = container.offset().top
            elHeight = el.outerHeight()
            viewHeight = $(window).height()

            # Fixed scrolling
            if (scrollTop + viewHeight) < (containerTop + elHeight)
              el
                .removeClass('bottom fixed')
                .addClass('fixed')
                .trigger('nc-fixed')
                .css
                  top: 0
            else
              if scrollTop > offset
                if (scrollTop + viewHeight) < (containerTop + containerHeight)
                  el
                    .addClass('bottom fixed')
                    .removeAttr('style')
                    .trigger('nc-fixed-bottom')
                    .css
                      top: auto
                      left: curpos.left
                else
                  el
                    .removeClass('bottom')
                    .removeAttr('style')
                    .trigger('nc-fixed')
                    .css
                      top: "#{containerHeight - elHeight}px"

            return

        if settings.manual is false
            $(window)
                .on 'scroll.autofix_anything, resize.autofix_anything', ->
                    fixAll el, settings, el.data['curpos']
                    return
            return
    ### 
    AUTOFIX_ANYTHING DATA-API
    =========================
    ###
    $(window).on 'load', ->
        $('[data-spy="autofix_anything"]').each ->
            $spy = $(@)
            data = $spy.data()

            options = {}
            for key of defaults
                options[key] = data[key.toLowerCase()]

            $spy.autofix_anything options

            return
        return
    return

