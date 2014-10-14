$(document).ready(function(){
  var selection;
  var highlighter;

  $('#sandbox').textHighlighter({
    onRemoveHighlight: function(highlight) {
      return true;
    },
    onBeforeHighlight: function(range) {
      $('.popover').popover('destroy');
      highlighter.removeHighlights();

      selection = window.getSelection() ;
      console.log(selection);
      return true;
      //TODO interact with popover. do not "Highlight" a popover
    },
    onAfterHighlight: function(highlights, range) {
      $(highlights).popover({ content: 'Annotate?', placement: 'top' }).popover('show');
      $(".popover").click(function(){
        var jsonStr = highlighter.serializeHighlights();
        console.log(jsonStr);
        console.log(highlights);
        $('.popover').popover('destroy');
        $(".highlighted").popover({ content: range, placement: 'top' }).popover('show');
      });

      //  $(highlights).wrap( "<a data-annon=\"45\" href=\"#\"></a>" );
      //highlighter.removeHighlights();
    }
  });

  highlighter = $('#sandbox').getHighlighter();

  $('body').on('mousedown', function (e) {
    var $target = $(e.target);
    if (!$target.is('[class^="popover"]') && ($(".popover").length > 0)) {
      $('.popover').popover('destroy');
      highlighter.removeHighlights();
    }
  });
  // $('p').on('mouseup', function(e){
  //   var selection;
  //   var range;
  //   selection = window.getSelection(e);
  //   range = selection.getRangeAt(0);
  //   if (!range.collapsed) {;
  //     var $target = $(e.target);
  //     // console.log(selection);
  //     console.log(range);
  //     // $("#sandbox").popover({ content: 'Annotate?', placement: 'top' }).popover('show');
  //   } else {
  //     $("#sandbox").popover({ content: 'Annotate?', placement: 'top' }).popover('show');
  //   }
  // });
  //
  // //practice
  var chapter_id = $('#chapter_id').val();
  $.getJSON( chapter_id + ".json", function( data ) {
    $data = JSON.stringify(data)
    console.log($data);

    data.sort(function(a,b){
      return a.offset - b.offset;
    });
    var global_offset = 0;
    data.forEach(function(annotation, index) {

      var note = annotation.note;
      var pre = '<u title="' + note + '" data-toggle="tooltip">';
      var post = '</u>'
      var offset = global_offset + annotation.offset;
      global_offset += pre.length + post.length;
      var length = annotation.length;
      var original_word = annotation.original_word;
      //  original_word.wrap( "<a data-annon=\"45\" href=\"#\"></a>" );
      var text = $('#sandbox').html();
      var p1 = text.substring(0, offset);
      var p2 = pre + original_word + post;
      var p3 = text.substring(offset + length, text.length-1);
      $('#sandbox').html(p1 + p2 + p3);
    });
    $('[data-toggle=tooltip]').tooltip({
      'trigger': 'hover',
      'html': false
    });
  });
});
