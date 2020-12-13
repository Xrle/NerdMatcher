$(document).on('turbolinks:load', () => {
    if (window.location.pathname === '/chat/show_messages') {
        $(document).scrollTop($(document).height());
    }
});