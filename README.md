dita-ot-pdf-css-page
====================

DITA Open Toolkit plugin to generate PDF output using CSS Paged Media.

## Installation

1. Download and install one of the PDF formatters: 
    * [PDFReactor 8](http://www.pdfreactor.com/)
    * [Vivliostyle](http://vivliostyle.com/)
2. Download the plugin from [GitHub](https://github.com/xmlrocks/dita-ot-pdf-css-page/archive/master.zip).
3. Follow instructions at [Installing plug-ins](http://www.dita-ot.org/2.2/user-guide/plugins-installing.html) DITA-OT documentation page. 

## Running the plugin

Run DITA-OT with `pdf-css-page` transformation type. 

### Plugin parameters:

- `html.pdf.formatter.path` – PDF formatter installation path.

### Optional parameters:

- `html.pdf.formatter` (`pdfreactor`|`vivliostyle`) – HTML PDF formatter. Defaults to `pdfreactor`.
- `css.file` – location of the CSS file. If the property is not set, the basic stylesheet delivered with the plugin is used.  
- `toc` (`true`|`false`) – generate Table of Contents. Defaults to `true`. 
- `index` (`true`|`false`) – generate Index. Defaults to `true`.

```
dita -f pdf-css-page -i input-file -o output-dir \ 
    -Dhtml.pdf.formatter=vivliostyle \ 
    -Dhtml.pdf.formatter.path=path/to/formatter \
    -Dcss.file=css-file
```

The plugin was tested with DITA-OT 2.1, 2.2.