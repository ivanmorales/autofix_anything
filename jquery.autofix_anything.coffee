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
        parentOffset: 0

    $.fn.autofix_anything = (options)->
        settings = $.extend {}, defaults, options
        el = $(@)
        el.data['curpos'] = el.position()
        offset = settings.customOffset
        auto = 'auto'
        container = if settings.container? then el.closest(settings.container) else el.parent()

        el.addClass 'autofix_sb'

        resize = =>
            el.data['curpos'] = el.position()
            return

        fixAll = (el, settings, curpos)->
            pos = el.offset()
            # If fixed element is taller than the container, don't do anything
            if el.outerHeight() >= container.outerHeight()
                return

            top = if isNaN(settings.parentOffset) then $(settings.parentOffset).outerHeight() else settings.parentOffset

            offset = container.offset().top - top if settings.customOffset is false


            # Fixed scrolling
            if $(document).scrollTop() > offset and $(document).scrollTop() <= (container.height() - el.outerHeight() + offset)
                el
                    .removeClass('bottom')
                    .addClass('fixed')
                    .trigger('autofixed')
                    .css
                        top: "#{top}px"
                        left: pos.left
                        right: auto
                        bottom: auto
            else
                if $(document).scrollTop() > offset
                    if settings.onlyInContainer is true
                        # Past bottom limit
                        if $(document).scrollTop() > (container.height() - el.outerHeight() + offset)
                            el
                                .addClass('bottom fixed')
                                .removeAttr('style')
                                .trigger('autofixed-bottom')
                                .css
                                    left: curpos
                        else
                            el
                                .removeClass('bottom fixed')
                                .removeAttr('style')
                                .trigger('autofixed')
                else
                    # Normal scrolling before fixed
                    el
                        .removeClass('bottom fixed')
                        .removeAttr('style')
                        .trigger('autofixed')

            return

        if settings.manual is false
            $(window)
                .on 'scroll.autofix_anything, resize.autofix_anything', ->
                    fixAll el, settings, el.data['curpos']
                    return
                .on 'resize.autofix_anything', ->
                    resize()
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

