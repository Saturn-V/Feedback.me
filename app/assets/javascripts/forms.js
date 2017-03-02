//= require jquery.turbolinks

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val = 1;
  $(link).closest(".form-fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().after(content.replace(regexp, new_id));

  // if (association === 'categories') {
  //   $('#categories').append(content.replace(regexp, new_id));
  // } else if (association === 'questions'){
  //   $(link).parent().next(content.replace(regexp, new_id));
  // }
}
