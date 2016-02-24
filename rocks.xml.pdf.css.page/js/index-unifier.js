// This JavaScript file was kindly provided by PDFReactor support team.

window.onload = function() {
    var indexEntries = document.querySelectorAll("p.index-entry");
    var deleteList = [];
    // iterate index entries
    for (var i = 0; i < indexEntries.length; i++) {
        var indexEntry = indexEntries[i];
        var links = indexEntry.querySelectorAll("a[href^='#']");

        if (links.length > 1) {
            var previousPageIndex = null;

            for (var j = 0; j < links.length; j++) {
                var link = links[j];
                var href = link.getAttribute("href");
                var documentElement = document.getElementById(href.substring(1));

                if (documentElement) {
                    var currentPageIndex = ro.layout.getBoxDescriptions(documentElement.parentNode)[0].pageIndex;

                    if (previousPageIndex && previousPageIndex == currentPageIndex) {
                        deleteList.push(link);
                    }

                    previousPageIndex = currentPageIndex;
                }
            }
        }
    }

    for (var i = 0; i < deleteList.length; i++) {
        var element = deleteList[i];

        // remove the text after the link which should be a ","
        element.previousSibling.textContent = "";
        // remove the link
        element.parentNode.removeChild(element);
    }
}
