//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
  // EDIT SHOPPING LIST
  $('.product_checkbox').change(function() {
    var data = extractData(this);

    if (this.checked) {
      save(data);
    } else {
      destroy(data);
    }
  });

  $('.decrease-quantity').click(function() {
    decreaseQuantity(this);
    checkIfQuantityIsOne(this);

    var data = extractData(this);

    save(data);
  });

  $('.increase-quantity').click(function() {
    increaseQuantity(this);
    checkIfQuantityIsOne(this);

    var data = extractData(this);

    save(data);
  });

  // SHOW SOPPHING LIST
  $('.item_checkbox').change(function() {
    var data = extractData(this);
    toggleCrossedOutClass(this);

    toggleCollected(data);
  });
});

$(document).on('focusout', '#notes', function(){
    var data = extractData(this);

    save(data);
});

function extractData(element) {
  var item = $(element).closest('.item');
  var product_id = $(item).find('#product_id_').val();
  var list_id = $('#list_id').val();
  var quantity = $(item).find('#quantity').val();
  var notes = $(item).find('#notes').val();

  var data = {product_id: product_id,
              list_id: list_id,
              quantity: quantity,
              notes: notes};

  console.log(data);

  return data;
}

function save(data) {
    $.ajax({
      type: "POST",
      url: '/items',
      dataType: 'json',
      data: data
    })
    .done(function(data){
      console.log(data);
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert("error");
      console.log(errorThrown);
    });
}

function destroy(data) {
    $.ajax({
      type: "DELETE",
      url: '/items',
      dataType: 'json',
      data: data
    })
    .done(function(data){
      console.log(data);
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert("error");
      console.log(errorThrown);
    });
}

function toggleCollected(data) {
    $.ajax({
      type: "POST",
      url: '/items/collected',
      dataType: 'json',
      data: data
    })
    .done(function(data){
      console.log(data);
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert("error");
      console.log(errorThrown);
    });
}

function decreaseQuantity(element) {
  var item = $(element).closest('.item');
  decrease($(item).find('#quantity'));
}

function increaseQuantity(element) {
  var item = $(element).closest('.item');
  increase($(item).find('#quantity'));
}

function decrease(quantity){
  $(quantity).val(parseInt(quantity.val()) - 1);
}

function increase(quantity){
  $(quantity).val(parseInt(quantity.val()) + 1);
}

function checkIfQuantityIsOne(element) {
  var item = $(element).closest('.item');
  var quantity = parseInt($(item).find('#quantity').val());
  if (quantity === 1) {
    $(item).find('.decrease-quantity').prop('disabled', true);
  } else {
    $(item).find('.decrease-quantity').prop('disabled', false);
  }
}

function toggleCrossedOutClass(element) {
  var item = $(element).closest('.item-in-list');

  $(item).toggleClass('crossed-out');
}
