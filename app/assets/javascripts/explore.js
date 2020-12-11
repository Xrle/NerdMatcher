$(document).on('turbolinks:load', () => {
    //Stop buttons from staying focused when clicked
    $('.explore-button').click((event) => {
        $(event.target).blur()
    })
})

function changePhoto(direction) {
    //Get number of photos, return if none
    let count = $('img:not(.no-photos)').length
    if (count === 0) {
        return
    }

    //Get current photo and target photo
    let [currentPhoto] = $('img:not(.hide)').attr('id').split('-').slice(-1)
    let target
    if (direction === 'next') {
        target = +currentPhoto + 1
        if (target > count) {
            target = 1
        }
    }
    else {
        target = +currentPhoto - 1
        if (target < 1) {
            target = count
        }
    }

    //Update page
    $('#explore-photo-' + currentPhoto).addClass('hide')
    $('#explore-photo-' + target).removeClass('hide')
    $('#current-photo').html(target + '/' + count)
}


