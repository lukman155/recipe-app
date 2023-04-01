$(document).ready(function() {
    $('#recipe_public').change(function() {
      var public = $(this).prop('checked');
      $.ajax({
        url: '<%= toggle_public_recipe_path(@recipe) %>',
        type: 'PUT',
        dataType: 'json',
        data: { public: public },
        success: function(response) {
          if (response.public) {
            $('#public-status').text('Public Recipe');
          } else {
            $('#public-status').text('Not Public Recipe');
          }
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log('Error:', errorThrown);
        }
      });
    });
  });
  