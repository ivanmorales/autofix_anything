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
        el = $(@)
        curpos = el.position()
        offset = settings.customOffset
        pos = el.offset()
        auto = 'auto'
        container = if settings.container? then el.closest(settings.container) else el.parent()

        el.addClass 'autofix_sb'

        $.fn.manualfix = ->
            el = $(@)
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

            if $(document).scrollTop() > offset and $(document).scrollTop() <= (container.height() + (offset - $(window).height()))
                el
                    .removeClass('bottom')
                    .addClass('fixed')
                    .trigger('autofixed')
                    .css
                        top: 0
                        left: pos.left
                        right: auto
                        bottom: auto
                console.log 'fixed 1'
            else
                if $(document).scrollTop() > offset
                    if settings.onlyInContainer is true
                        if $(document).scrollTop() > (container.height() - $(window).height())
                            el
                                .addClass('bottom fixed')
                                .removeAttr('style')
                                .trigger('autofixed-bottom')
                                .css
                                    left: curpos.left
                            console.log 'fixed 2'
                        else
                            el
                                .removeClass('bottom fixed')
                                .removeAttr('style')
                                .trigger('autofixed'
                            console.log 'fixed 3')
                else
                    el
                        .removeClass('bottom fixed')
                        .removeAttr('style')
                        .trigger('autofixed'
                    console.log 'fixed 4')

            return

        if settings.manual is false
            $(window).on 'scroll.autofix_anything.scroll, resize.autofix_anything.resize', ->
                fixAll el, settings, curpos, pos
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

            $spy.autofix_anything
                customOffset: data.customOffset
                manual: data.manual
                onlyInContainer: data.onlyInContainer
                container: data.container

            return
        return
    return

