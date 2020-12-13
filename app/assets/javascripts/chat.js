$(document).on('turbolinks:load', () => {
    //Scroll to bottom of chat window on load
    if (window.location.pathname === '/chat/show_messages') {
        $(document).scrollTop($(document).height());
    }
});