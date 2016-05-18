window.onload = rewriteIndex;

function rewriteIndex() {
    var index = document.getElementById("index-chapter");
    if (index) {
        var paras = index.getElementsByTagName("p");

        for (var i = 0; i < paras.length; ++i) {
            var oldParagraph = paras[i];
            var newParagraph = document.createElement("p");

            newParagraph.appendChild(oldParagraph.childNodes[0]);

            var pages = {};
            var childNodes = oldParagraph.getElementsByTagName("a");
            for (var j = 0; j < childNodes.length; ++j) {
                var anchor = childNodes[j];
                var href = anchor.getAttribute("href");

                var pageNum = refs[href];
                if (pageNum) {
                    if (!pages[pageNum]) {
                        newParagraph.appendChild(anchor);
                        newParagraph.appendChild(document.createTextNode(", "));

                        pages[pageNum] = true;
                    }
                }
            }

            newParagraph.removeChild(newParagraph.lastChild);

            var parent = oldParagraph.parentNode;
            parent.replaceChild(newParagraph, oldParagraph);
        }
    }
}