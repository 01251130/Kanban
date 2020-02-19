$(function() {
  var targetClasses = ['.cardList'];

  $('.cardList').sortable({
    connectWith: targetClasses,
    update: function(e, ui) {
      let item = ui.item;
      console.log('update');
      console.log(item);
      let item_data = item.data();
      let params = { _method: 'put' };
      params[item_data.modelName] = {
        row_order_position: item.index()
      };
      // params[item_data.after] = $(this).sortable('serialize');
      // console.log(params);
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

    // 案は二つ
    // １：D&Dでの並び替えは、同一リスト内にする。
    // edit画面にてリストの並び替えを行なった場合、row_orderを最大値に更新し、最下部に来るようにする
    // ２：移動後のlist_idが取得できる方法を引き続き調べる。
    // これが解決すれば、sort_pathに渡すlist_idを変更することで実装できる想定。
  });
});
