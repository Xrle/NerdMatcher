$(document).on('turbolinks:load', () => {
    $('.explore-button').click((event) => {
        $(event.target).blur()
    })
})