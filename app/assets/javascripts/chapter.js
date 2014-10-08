function getSelectedWordIndex() {
    if (window.getSelection) {
        var sel = window.getSelection();
        var div = document.getElementById("content");
        if (sel.rangeCount) {
            // Get the selected range
            var range = sel.getRangeAt(0);
            alert(sel);
            alert(range);
            // Check that the selection is wholly contained within the div text
            // if (range.commonAncestorContainer == div.firstChild) {
            //     var precedingRange = document.createRange();
            //     precedingRange.setStartBefore(div.firstChild);
            //     precedingRange.setEnd(range.startContainer, range.startOffset);
            //     var textPrecedingSelection = precedingRange.toString();
            //     var wordIndex = textPrecedingSelection.split(/\s+/).length;
            //     alert("Word index: " + wordIndex);
            // }
        }
    }
}
