$(function() {
  $('.cardList').sortable({
    update: function(e, ui) {
      let item = ui.item;
      console.log('update');
      console.log(item);
      let item_data = item.data();
      let params = { _method: 'put' };
      params[item_data.modelName] = {
        row_order_position: item.index()
      };
      $.ajax({
        type: 'POST',
        url: item_data.updateUrl,
        dataType: 'json',
        data: params
      });
    },
    stop: function(e, ui) {
      console.log('stop');
      ui.item
        .children('div')
        .not('.item__status')
        .effect('highlight', { color: '#FFC' }, 500);
    }
  });
});
