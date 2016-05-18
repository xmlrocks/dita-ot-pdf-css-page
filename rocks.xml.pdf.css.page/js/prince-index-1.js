var refs = {};

function index(href, counter) {
    refs[href] = counter;
    return counter;
}

function dumpIndex() {
    console.log("var refs = {");
    var index = document.getElementById("index-chapter");
    if (index) {
        var keys = [];

        var index = document.getElementById("index-chapter");
        var anchors = index.getElementsByTagName("a");

        for (var i = 0; i < anchors.length; ++i) {
            var anchor = anchors[i];
            var href = anchor.getAttribute("href");

            if (refs[href]) {
                keys.push(href);
            }
        }

        keys.sort();

        for (i in keys) {
            var comma = (i < keys.length - 1 ? "," : "");
            console.log("\"" + keys[i] + "\": " + refs[keys[i]] + comma);
        }
    }

    console.log("};");
}

Prince.addScriptFunc("index", index);
Prince.addEventListener("complete", dumpIndex, false);