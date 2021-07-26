// リサイズ時、ピンの画像サイズ変更
$(document).bind('turbolinks:load ajaxComplete', function() {
  // 置換の対象とするclass属性。
  const $elem = $('.js-image-switch');
  // 置換の対象とするsrc属性の末尾の文字列。
  const sp = '_sp.';
  const pc = '_pc.';
  const lpc = '_lpc.';
  // 画像を切り替えるウィンドウサイズ。
  const replaceWidth = 765;
  const replaceWidthLpc = 991;

  function imageSwitch() {
    // ウィンドウサイズを取得する。
    let windowWidth = parseInt(window.innerWidth);

    // ページ内にあるすべての`.js-image-switch`に適応される。
    $elem.each(function() {
      let $this = $(this);
      // ウィンドウサイズが991px以上であれば_pcを_lpcに置換する。
      if(windowWidth >= replaceWidthLpc) {
        $this.attr('src', $this.attr('src').replace(pc, lpc));
        $this.attr('src', $this.attr('src').replace(sp, lpc));
        // ウィンドウサイズが765px以上であれば_spを_pcに置換する。
      }else if(windowWidth >= replaceWidth) {
        $this.attr('src', $this.attr('src').replace(lpc, pc));
        $this.attr('src', $this.attr('src').replace(sp, pc));

      // ウィンドウサイズが765px未満であれば_pcを_spに置換する。
      } else {
        $this.attr('src', $this.attr('src').replace(pc, sp));
        $this.attr('src', $this.attr('src').replace(lpc, sp));
      };
    });
  };
  imageSwitch();

  // 動的なリサイズは操作後0.01秒経ってから処理を実行する。
  let resizeTimer;
  $(window).on('resize', function() {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(function() {
      imageSwitch();
    }, 10);
  });
});