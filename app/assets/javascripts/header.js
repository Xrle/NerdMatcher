$(document).on('turbolinks:load', () => {
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