//application javascript for focusing form first text field element.
//Apply the id "first_field_focus" to the first text field to utilize.
//Make sure that there is no more than one form being rendered on a page
//or there will be a conflict as to which element to focus on.

$(document).ready(function(){
    $("#first_field_focus").focus();

});