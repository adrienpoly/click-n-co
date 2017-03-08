$('#order-show').on('show.bs.modal', function (event) {
   var $modal = $(this);
   var button = $(event.relatedTarget);
   var orderId = button.data('orderid');
   $.ajax({
     url: "orders/" + orderId,
     success: function(data){
         $modal.find('.modal-body').html(data)
     }
   });
})
