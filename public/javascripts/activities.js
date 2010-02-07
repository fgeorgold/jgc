function onActivityUpdateSuccess() {
    alert('success')
}

function onActivityUpdateFailure() {
    alert('fail')
}

function init() {
    Event.observe($('activity-submit'), 'click', function() {
        var form = $('activity-form');
    
        new Ajax.Request(form.getAttribute('action'), {
            method: 'put',
            parameters: form.serialize(true),
            onSuccess: onActivityUpdateSuccess,
            onFailure: onActivityUpdateFailure
        });
        
    });    
}

Event.observe(window, 'load', init, false)
