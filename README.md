xml-to-json-fast
================

Fast, light converter of xml to json capable of handling huge xml files


The fast, simple `xml-to-json-fast` executable provides an unambiguous one-to-one mapping of xml data to json data. It is suitable for very large xml files (has been tested on a 500MB file) and uses very little memory. However, `xml-to-json-fast` doesn't provide for any control over the output. Please see the other project, [xml-to-json](https://github.com/sinelaw/xml-to-json).

When using "fast" (`xml-to-json-fast`), the output reflects the exact structure of the xml, which is allowed to be somewhat malformed (resulting in invalid json).

**Formatting:** Currently `xml-to-json-fast` does **not** format the resulting json. If whitespace formatting is required, you can use a json formatting program such as [aeson-pretty](https://hackage.haskell.org/package/aeson-pretty) (on debian/ubuntu, can be install with `sudo apt-get install aeson-pretty`). Note that most of the json formatters are memory bound, so very large json files may cause the formatter to run out of memory.
