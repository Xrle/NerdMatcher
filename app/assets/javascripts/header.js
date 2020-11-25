$(document).on('turbolinks:load', () => {
    //Get navbar link for current page and make it active
    let el = $('.nav-link[href="' + window.location.pathname + '"]').parent()
    el.addClass('active')
})