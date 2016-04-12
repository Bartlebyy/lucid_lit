$(document).ready(function(){
  var selection;
  var highlighter;

  // $('#sandbox').textHighlighter({
  //   onRemoveHighlight: function(highlight) {
  //     return true;
  //   },
  //   onBeforeHighlight: function(range) {
  //     $('.popover').popover('destroy');
  //     highlighter.removeHighlights();
  //
  //     // selection = window.getSelection() ;
  //     //console.log(selection);
  //     return true;
  //     //TODO interact with popover. do not "Highlight" a popover
  //   },
  //   onAfterHighlight: function(highlights, range) {
  //     $(highlights).popover({ content: 'Annotate?', placement: 'top' }).popover('show');
  //     $(".popover").click(function(){
  //       // var jsonStr = highlighter.serializeHighlights();
  //       // console.log(jsonStr);
  //       // console.log(highlights);
  //
  //       $('.popover').popover('destroy');
  //
  //       $(".modal").modal('show');
  //       $("#original_word").text('"'+range+'"');
  //       $("#annotation_original_word").val(range);
  //       $("#annotation_length").val(range.length);
  //       $("#annotation_offset").val(highlights[0].previousSibling.length);
  //       highlighter.removeHighlights();
  //     });
  //
  //     //  $(highlights).wrap( "<a data-annon=\"45\" href=\"#\"></a>" );
  //   }
  // });
  //
  // highlighter = $('#sandbox').getHighlighter();
  //
  // $('body').on('mousedown', function (e) {
  //   var $target = $(e.target);
  //   if (!$target.is('[class^="popover"]') && ($(".popover").length > 0)) {
  //     $('.popover').popover('destroy');
  //     highlighter.removeHighlights();
  //   }
  // });
  //
  // $("form").submit(function() {
  //   $(".modal").modal('hide');
  //   location.reload();
  // });
  // $("#sandbox").popover({
  //   content: 'Annotate?',
  //   placement: 'top',
  //   trigger: 'manual'
  // });
  //
  // $('p').on('mouseup', function(){
  //   var selection, range;
  //   selection = window.getSelection();
  //   range = selection.getRangeAt(0);
  //   // console.log(isRange);
  //   if (selection.type == 'Range') {
  //     // console.log(range);
  //     $("#sandbox").popover('show');
  //   } else {
  //     $("#sandbox").popover('hide');
  //   }
  //   // if (!range.collapsed) {;
  //   //   var $target = $(e.target);
  //   //   // console.log(selection);
  //   //   console.log(range);
  //   //   // $("#sandbox").popover({ content: 'Annotate?', placement: 'top' }).popover('show');
  //   // } else {
  //   //   $("#sandbox").popover({ content: 'Annotate?', placement: 'top' }).popover('show');
  //   // }
  // });
var mousePos;
$(document).mousemove(function (e) {
    mousePos = {left: e.pageX + 20, top: e.pageY + 20};
});

var selectedText = '';
function getSelectedText(){
    if(window.getSelection){
        return window.getSelection().toString();
    }
    else if(document.getSelection){
        return document.getSelection();
    }
    else if(document.selection){
        return document.selection.createRange().text;
    }
}

function checkSelectionChanged() {
    var current = getSelectedText();
    if(current != selectedText) {
        selectedText = current;
        if(selectedText != '') {
            console.log(selectedText);
            console.log(mousePos);
            $('p').click(function (e) {
                var offset = $(this).offset();
                var left = e.pageX;
                var top = e.pageY;
                var theHeight = $('.popover').height();
                $('.popover').show();
                $('.popover').css('left', (left+10) + 'px');
                $('.popover').css('top', (top-(theHeight/2)-10) + 'px');
            });
            $('#quote #text').text(selectedText);
            $('#quote').offset(mousePos);
            $('#quote').show();
        } else {
            $('.popover').hide();
            $('#quote').hide();
        }
    }
}

$("p").on("mouseup", checkSelectionChanged);



  var chapter_id = $('#chapter_id').val();
  $.getJSON( chapter_id + ".json", function( data ) {
    data.sort(function(a,b){
      return a.offset - b.offset;
    });
    var global_offset = 0;
    data.forEach(function(annotation, index) {

      var note = annotation.note;
      var offset = global_offset + annotation.offset;
      var length = annotation.length;
      var pre = '<u title="' + note + '" data-toggle="tooltip" data-offset="' + (offset+length) + '">';
      var post = '</u>'

      global_offset += pre.length + post.length;

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
