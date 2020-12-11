$(document).on('turbolinks:load', () => {
    //Only make header fixed if not on home page as fixed header on the home page causes issues
    if (window.location.pathname === '/') {
        $('#header > nav').removeClass('is-fixed-top')
        $('html').removeClass('has-navbar-fixed-top')
    }
    else {
        $('#header > nav').addClass('is-fixed-top')
        $('html').addClass('has-navbar-fixed-top')
    }

    //Get navbar link for current page and make it active
    $('.navbar-item[href="' + window.location.pathname + '"]').addClass('is-active')

    //Activate hamburger menu on click
    $('.navbar-burger').click(() => {
        $('.navbar-burger').toggleClass('is-active')
        $('.navbar-menu').toggleClass('is-active')
    })

    //Delete flash messages when button pressed
    $('button.delete').click((event) => {
        $(event.target).parent().parent().remove()
    })
})