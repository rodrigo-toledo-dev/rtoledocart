$(document).on 'turbolinks:load', ->
  $('.description').hover ->
    $(this).next('.add_to_cart').show()
    return
  $('#product_order').change ->
    $.get
      url: $(this).data('action')
      type: 'get'
      data: order: $(this).val()
      dataType: 'json'
      error: (response) ->
        $('.products_list').html response.responseText
        $('.description').hover ->
          $(this).next('.add_to_cart').show()
          return
        return
    return