###
 ===========================================================
 * jquery.autofix_anything.js v1
 * ===========================================================
 * Copyright 2013 Pete Rojwongsuriya.
 * http://www.thepetedesign.com
 *
 * Fix position of anything on your website automatically
 * with one js call
 *
 * https://github.com/peachananr/autofix_anything
 *
 * ========================================================== ###

do($ = jQuery, window)->
    defaults = 
        customOffset: false
        manual: false
        onlyInContainer: true
        container: null

    $.fn.autofix_anything = (options)->
        settings = $.extend {}, defaults, options
        el = $(this)
        curpos = el.position()
        offset = settings.customOffset
        pos = el.offset()
        auto = 'auto'
        container = if settings.container? then el.closest(settings.container) else el.parent()

        el.addClass 'autofix_sb'

        $.fn.manualfix = ->
            el = $(this)
            pos = el.offset()

            if el.hasClass('fixed')
                el.removeClass('fixed')
            else
                el
                    .addClass('fixed')
                    .css
                        top: 0
                        left: pos.left
                        right: auto
                        bottom: auto
            return

        fixAll = (el, settings, curpos, pos)->
            offset = container.offset().top if settings.customOffset is false

            if $(document).scrollTop > offset and $(document).scrollTop() <= (container.height() + (offset - $(window).height()))
                el
                    .removeClass('bottom')
                    .addClass('fixed')
                    .css
                        top: 0
                        left: pos.left
                        right: auto
                        bottom: auto
            else
                if $(document).scrollTop() > offset
                    if settings.onlyInContainer is true
                        if $(document).scrollTop() > (container.height() - $(window).height())
                            el
                                .addClass('bottom fixed')
                                .removeAttr('style')
                                .css
                                    left: curpos.left
                        else
                            el
                                .removeClass('bottom fixed')
                                .removeAttr('style')
                else
                    el
                        .removeClass('bottom fixed')
                        .removeAttr('style')

            return

        if settings.manual is false
            $(window).scroll ->
                fixAll el, settings, curpos, pos
                return
            return
    return
