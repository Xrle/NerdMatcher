$(document).on('turbolinks:load', () => {
    //Stop buttons from staying focused when clicked
    $('.explore-button').click((event) => {
        $(event.target).blur()
    })
})