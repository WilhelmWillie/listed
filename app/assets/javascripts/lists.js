$(document).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();

  var url = window.location.href;

  $('.list-item .move-item-up').click(function(e) {
    $listItem = $(this).parents('.list-item');
    $prevListItem = $listItem.prev();
    
    // Moves the targeted list item before the previous item (Client swap)
    $listItem.insertBefore($prevListItem);

    // Sends a POST request that will update the order in the database (Server swap)
    $.post(url + '/items/' + $listItem.data('item-id') + '/swap/' + $prevListItem.data('item-id'));

    // If the list item is now out of view because of the swap, scroll the window down
    $('html, body').animate({
      scrollTop: $listItem.offset().top - $('.navbar').height() - 15
    }, 300);

    e.preventDefault();
  });

  $('.list-item .move-item-down').click(function(e) {
    $listItem = $(this).parents('.list-item');
    $nextListItem = $listItem.next();

    $listItem.insertAfter($listItem.next());

    $.post(url + '/items/' + $listItem.data('item-id') + '/swap/' + $nextListItem.data('item-id'));

    $('html, body').animate({
      scrollTop: $listItem.offset().top - $('.navbar').height() - 15
    }, 300);

    e.preventDefault();
  });

  // Update the edit item form so its fitted for the targeted list item
  $('.edit-item').click(function(e) {
    $listItem = $(this).parents('.list-item');

    var newAction = url + '/items/' + $listItem.data('item-id');

    $('#editItemForm').attr('action', newAction);
    $('#editItemName').val($listItem.children('.item-title').html());
    $('#editItemDescription').val($listItem.children('.item-description').html());
  });

  // Clicking the like button sends a simple POST request to the server that will create or delete a like pending if the user already likes the list
  $('#like-list').click(function(e) {
    // Send POST request to server to like/unlike the list
    $.post(url + '/like', function(data) {
      // Once data is received, we update the clients view
      $('#like-list').toggleClass('user-likes-list');
      $('.like-count').html(data.like_count);
    });
  });
});