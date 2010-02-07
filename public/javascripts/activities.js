
function onBasicInfoEdit() {

}

function onBasicInfoSave() {

}

function onWhereAndWhenEdit() {
    
}

function onWhereAndWhenSave() {

}

function onResourcesAndCostsEdit() {

}

function onResourcesAndCostsSave() {

}

function onCommentSubmit() {
    $('comment_form').submit();
}

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
        
        Event.observe($('basic-info-edit'), 'click', onBasicInfoEdit);
        Event.observe($('where-and-when-edit'), 'click', onWhereAndWhenEdit);
        Event.observe($('resources-and-costs-edit'), 'click', onResourcesAndCostsEdit);
        Event.observe($('comment_button_link'), 'click', onCommentSubmit);
    });    
}

Event.observe(window, 'load', init, false);
