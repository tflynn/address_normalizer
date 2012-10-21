# address_normalizer #

(c) 2012 Tracy Flynn
address_normalizer may be freely distributed under the MIT license.

Version 0.0.1

## Description ##

address_normalizer is a library that standardizes US Postal Addresses, and individual and business names.

## Prerequisites ##

### Ruby environment ###

* Ruby 1.9 (>= 1.9.1)
* hpricot (>0.8.6)

## Tools ##

### extract-business-abbreviations.rb ###

Extract business abbreviations from the [USPS page of business abbreviations](http://pe.usps.com/text/pub28/28apg.htm).

#### To run ####

ruby ./utilities/extract-business-abbreviations.rb 

#### Output ####

Tab-separated list in './references/business-abbreviations.tsv'

* First element: Common presentation
* Second element: USPS Standard abbreviation

### extract-state-abbreviations.rb ###

Extract state abbreviations, geographical directionals and military state abbreviations from the [USPS page of state abbreviations](http://pe.usps.com/text/pub28/28apb.htm).

Note: There are HTML markup errors in the web version of the page that are corrected in the local copy.

#### To run ####

ruby ./utilities/extract-state-abbreviations.rb 

#### Output ####

Tab-separated lists

State abbreviations - './references/state-abbreviations.tsv'

* First element: Full state name
* Second element: USPS Standard abbreviation

Geographic directional abbreviations - './references/geographic-directionals-abbreviations.tsv'

* First element: Geographic Directional
* Second element: USPS Standard abbreviation

Military 'state' abbreviations - './references/military-states-abbreviations.tsv'

* First element: Military 'state'
* Second element: USPS Standard abbreviation

### extract-street-suffix-abbreviations.rb ###

Extract street suffix abbreviations from the [USPS page of street suffix abbreviations](http://pe.usps.com/text/pub28/28apc_002.htm).

Note: There are HTML markup errors in the web version of the page that are corrected in the local copy.

#### To run ####

ruby ./utilities/extract-street-suffix-abbreviations.rb 

#### Output ####

Tab-separated list in './references/street-suffix-abbreviations.tsv'

* First element: Common presentation
* Second element: USPS Standard abbreviation

