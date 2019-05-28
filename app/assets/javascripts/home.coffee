$(document).ready ->
  $('.description').hover ->
    $(this).next('.add_to_cart').show()
    return