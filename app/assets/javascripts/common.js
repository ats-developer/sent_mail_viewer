$(document).ready(function() {
    $('#sign-in-button').bind('click', function() {
        $.blockUI({
            message: '<strong>Please wait while we authenticating...</strong>',
            css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff'
            } });
    });
    $("#messages_search input").keyup(function() {
        $.get($("#messages_search").attr("action"), $("#messages_search").serialize(), null, "script");
        return false;
    });
});