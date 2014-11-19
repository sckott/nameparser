nameparser
============

`nameparser` parses taxonomic names. It's an R port of the Ruby gem `biodiversity`.


## Installation


```r
devtools::install_github("sckott/nameparser")
```

## Examples

You can use it as a library in Ruby, JRuby etc.

to fix capitalization in canonicals


```r
ScientificNameParser.fix_case("QUERCUS (QUERCUS) ALBA")
# Output: Quercus (Quercus) alba
```

to parse a scientific name into a ruby hash


```r
parser.parse("Plantago major")
```

to get json representation


```r
parser.parse("Plantago").to_json
#or
parser.parse("Plantago")
parser.all_json
```

to clean name up


```r
parser.parse("      Plantago       major    ")[:scientificName][:normalized]
```

to get only cleaned up latin part of the name


```r
parser.parse("Pseudocercospora dendrobii (H.C. Burnett) U. \
Braun & Crous 2003")[:scientificName][:canonical]
```

to get detailed information about elements of the name


```r
parser.parse("Pseudocercospora dendrobii (H.C. Burnett 1883) U. \
Braun & Crous 2003")[:scientificName][:details]
```

Returned result is not always linear, if name is complex. To get simple linear
representation of the name you can use:


```r
parser.parse("Pseudocercospora dendrobii (H.C. Burnett) \
U. Braun & Crous 2003")[:scientificName][:position]
# returns {0=>["genus", 16], 17=>["species", 26],
# 28=>["author_word", 32], 33=>["author_word", 40],
# 42=>["author_word", 44], 45=>["author_word", 50],
# 53=>["author_word", 58], 59=>["year", 63]}
# where the key is the char index of the start of
# a word, first element of the value is a semantic meaning
# of the word, second element of the value is the character index
# of end of the word
```

'Surrogate' is a broad group which includes 'Barcode of Life' names, and various
undetermined names with cf. sp. spp. nr. in them:


```r
parser.parse("Coleoptera BOLD:1234567")[:scientificName][:surrogate]
```

To parse using several CPUs (4 seem to be optimal)


```r
parser = ParallelParser.new
# ParallelParser.new(4) will try to run 4 processes if hardware allows
array_of_names = ["Betula alba", "Homo sapiens"....]
parser.parse(array_of_names)
# Output: {"Betula alba" => {:scientificName...},
# "Homo sapiens" => {:scientificName...}, ...}
```

parallel parser takes list of names and returns back a hash with names as
keys and parsed data as values

To get canonicals with ranks for infraspecific epithets:


```r
parser = ScientificNameParser.new(canonical_with_rank: true)
parser.parse('Cola cordifolia var. puberula \
A. Chev.')[:scientificName][:canonical]
# Output: Cola cordifolia var. puberula
```

To resolve lsid and get back RDF file


```r
LsidResolver.resolve("urn:lsid:ubio.org:classificationbank:2232671")
```
